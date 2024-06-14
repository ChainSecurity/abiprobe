use std::{
    fs,
    io::Write,
    str,
    time::{SystemTime, UNIX_EPOCH},
    vec,
};

use crate::{error::ABIProbeError, sway_converter::SwayConverter, Encoding};
use fuels::{
    core::{codec::ABIDecoder, traits::Parameterize},
    macros::abigen,
    test_helpers::launch_provider_and_get_wallet,
    types::{param_types::ParamType, RawSlice, Token},
};
use tokio::runtime::Runtime;
use tracing::{info, debug, warn};

const OUTPUT_PATH: &str = "./forc_project/src/main.sw";
const SWAY_COMPILATION_FAIL: &str = "Failed to compile";
const BUILD_COMMAND: &str = "forc build --path ./forc_project/";
const BIN_PATH: &str = "forc_project/out/debug/forc_project.bin";
const ABI_PATH: &str = "forc_project/out/debug/forc_project-abi.json";
pub struct Sway {
    output_folder: String,
}

impl Sway {
    pub fn new(output_folder: &String) -> Self {
        // Create sway_reverts folder if not exists
        fs::create_dir_all(format!("{}/sway_reverts/", output_folder)).unwrap();
        fs::create_dir_all(format!("{}/compilation_errors/sway", output_folder)).unwrap();

        Self {
            output_folder: output_folder.clone(),
        }
    }

    pub fn exercise_abi(
        &self,
        samples: &Vec<(ParamType, Vec<Token>)>,
    ) -> (Vec<Encoding>, Vec<Vec<bool>>) {
        let mut converter = SwayConverter::new();

        let src = converter.convert_to_src(samples);

        let mut file = fs::File::create(OUTPUT_PATH).unwrap();
        file.write_all(src.as_bytes()).unwrap();

        match self.build_sway_script() {
            Ok(_) => (),
            Err(e) => {

                let foldername = SystemTime::now()
                    .duration_since(UNIX_EPOCH)
                    .expect("Time went backwards")
                    .as_secs();

                fs::create_dir_all(format!(
                    "{}/compilation_errors/sway/{}",
                    self.output_folder, foldername
                ))
                .unwrap();

                let mut file = fs::File::create(format!(
                    "{}/compilation_errors/sway/{}/log.txt",
                    self.output_folder, foldername
                ))
                .unwrap();

                file.write_all(e.to_string().as_bytes()).unwrap();

                // Write code into code.sw file in folder
                let mut code_file = fs::File::create(format!(
                    "{}/compilation_errors/sway/{}/code.sw",
                    self.output_folder, foldername
                ))
                .unwrap();
                let sway_code = fs::read_to_string(OUTPUT_PATH).unwrap();
                code_file.write_all(sway_code.as_bytes()).unwrap();

                warn!("Failed to build Sway: {:?}", e);

                // Return empty vec as the compilation failed
                return (vec![], vec![]);
            }
        }

        self.run_sway_script()
    }

    pub fn build_sway_script(&self) -> Result<(), ABIProbeError> {
        // Run build command
        let output = std::process::Command::new("sh")
            .arg("-c")
            .arg(BUILD_COMMAND)
            .output()
            .map_err(|e| {
                ABIProbeError::SwayCommandError(format!(
                    "Failed to run sway build command: {:?}",
                    e
                ))
            })?;

        // NOTE This can be improved to get a better formatted error message
        let stdout = String::from_utf8_lossy(&output.stdout);
        let stderr = String::from_utf8_lossy(&output.stderr);

        if !output.status.success() {
            return Err(ABIProbeError::SwayCommandError(format!(
                "Command failed with status {}: {}",
                output.status, stderr
            )));
        }

        if stdout.contains(SWAY_COMPILATION_FAIL) {
            return Err(ABIProbeError::SwayCompilationError(format!(
                "Failed to compile sway script: {:?}",
                output.stdout
            )));
        }

        Ok(())
    }

    pub fn run_sway_script(&self) -> (Vec<Encoding>, Vec<Vec<bool>>) {
        let runtime = Runtime::new().expect("Failed to create Tokio runtime");

        runtime.block_on(async {
            abigen!(Script(
                name = "SwayScript",
                abi = "forc_project/out/debug/forc_project-abi.json"
            ));

            let abi = fs::read_to_string(ABI_PATH).expect("Failed to read ABI file");
            debug!("Sway ABI: {:?}", abi);

            let wallet = launch_provider_and_get_wallet()
                .await
                .expect("Failed to get wallet");

            let script_instance = SwayScript::new(wallet, BIN_PATH);

            let response = match script_instance.main().call().await {
                Ok(response) => response,
                Err(e) => {
                    let foldername = SystemTime::now()
                        .duration_since(UNIX_EPOCH)
                        .expect("Time went backwards")
                        .as_secs();

                    fs::create_dir_all(format!(
                        "{}/sway_reverts/{}",
                        self.output_folder, foldername
                    ))
                    .unwrap();
                    let mut file = fs::File::create(format!(
                        "{}/sway_reverts/{}/log.txt",
                        self.output_folder, foldername
                    ))
                    .unwrap();
                    file.write_all(e.to_string().as_bytes()).unwrap();

                    let sway_code = fs::read_to_string(OUTPUT_PATH).unwrap();

                    let mut code_file = fs::File::create(format!(
                        "{}/sway_reverts/{}/code.sw",
                        self.output_folder, foldername
                    ))
                    .unwrap();
                    code_file.write_all(sway_code.as_bytes()).unwrap();

                    return (vec![], vec![]);
                }
            };

            let logs = response.decode_logs();
            let receipts = response.receipts;
            debug!("Sway log receipts: {:?}", receipts);

            let str_logs = logs
                .results
                .iter()
                .map(|elem| elem.as_ref().expect("Failed to get log").clone());

            let t: Vec<Token> = str_logs
                .zip(&receipts)
                .into_iter()
                .map(|(log, receipt)| {
                    let bytes = receipt.data().unwrap();
                    // If raw slice in string then RawSlice type else, boolean type
                    if log.contains("RawSlice") {
                        let token = ABIDecoder::new(Default::default())
                            .decode(&RawSlice::param_type(), &bytes)
                            .unwrap();
                        return token;
                    } else {
                        let token = ABIDecoder::new(Default::default())
                            .decode(&bool::param_type(), &bytes)
                            .unwrap();
                        return token;
                    }
                })
                .collect();

            debug!("Sway extracted log tokens: {:?}", t);

            let mut encodings = Vec::new();
            let mut decodings = Vec::new();
            let mut remaining = t.iter().peekable();

            while let Some(token) = remaining.next() {
                if let Token::RawSlice(slice) = token {
                    let byte_array = slice.clone();
                    encodings.push(byte_array);

                    let mut bools = Vec::new();
                    while let Some(next_token) = remaining.peek() {
                        if let Token::Bool(b) = next_token {
                            bools.push(b.clone());
                            remaining.next();
                        } else {
                            break;
                        }
                    }
                    if !bools.is_empty() {
                        decodings.push(bools);
                    }
                }
            }

            debug!("Sway encodings: {:?}", encodings);
            debug!("Sway decodings: {:?}", decodings);

            return (encodings, decodings);
        })
    }
}

#[cfg(test)]
mod tests {
    use fuels::types::param_types::EnumVariants;

    use super::*;
    type P = ParamType;
    type T = Token;
    #[test]
    fn test_exercise_abi_sway_enum_vector() {
        let sway = Sway::new(&"output".to_string());
        let vector_type = P::Vector(Box::new(P::U64));
        let vector_token: T = T::Vector(vec![T::U64(1), T::U64(2)]);
        let unit_type = P::Unit;
        let enum_variants = EnumVariants::new(vec![
            ("AVec".to_string(), vector_type),
            ("AVariant".to_string(), unit_type),
        ])
        .unwrap();
        let enum_type = P::Enum {
            name: "MyEnum".to_string(),
            enum_variants: enum_variants.clone(),
            generics: vec![],
        };

        let enum_token = T::Enum(Box::new((0, vector_token, enum_variants.clone())));

        let samples = vec![(enum_type, vec![enum_token])];
        sway.exercise_abi(&samples);
    }

    #[test]
    fn test_exercise_abi_sway_enum_unit() {
        let sway = Sway::new(&"output".to_string());
        let vector_type = P::Vector(Box::new(P::U64));
        let _vector_token: T = T::Unit;
        let unit_type = P::Unit;
        let enum_variants = EnumVariants::new(vec![
            ("aVec".to_string(), vector_type),
            ("aVariant".to_string(), unit_type),
        ])
        .unwrap();
        let enum_type = P::Enum {
            name: "MyEnum".to_string(),
            enum_variants: enum_variants.clone(),
            generics: vec![],
        };

        let enum_token = T::Enum(Box::new((1, Token::Unit, enum_variants.clone())));
        let samples = vec![(enum_type, vec![enum_token])];
        sway.exercise_abi(&samples);
    }
}
