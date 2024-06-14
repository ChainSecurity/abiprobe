use std::{
    fs,
    io::Write,
    time::{SystemTime, UNIX_EPOCH},
    vec,
};

use fuels::types::{param_types::ParamType, Token};
use tracing::{debug, info, warn};

use crate::{error::ABIProbeError, ts_converter::TSConverter, Encoding};

const TS_SDK: &str = "ts-sdk";
const OUTPUT_PATH: &str = "ts-sdk/index.ts";

pub struct Ts {
    output_folder: String,
}

impl Ts {
    pub fn new(output_folder: &String) -> Self {
        // Compilation errors folder ts
        fs::create_dir_all(format!("{}/compilation_errors/ts", output_folder)).unwrap();

        Self {
            output_folder: output_folder.clone(),
        }
    }

    pub fn exercise_abi(
        &self,
        samples: &Vec<(ParamType, Vec<Token>)>,
    ) -> (Vec<Encoding>, Vec<bool>) {
        let mut converter = TSConverter::new();

        let src = converter.convert_to_src(samples);

        let mut file = fs::File::create(OUTPUT_PATH).unwrap();
        file.write_all(src.as_bytes()).unwrap();

        match self.run_typescript() {
            Ok(output_str) => {
                let encodings = self.extract_encodings(&output_str);
                let decodings = self.extract_decodings(&output_str);

                debug!("TS encodings: {:?}", encodings);
                debug!("TS decodings: {:?}", decodings);
                (encodings, decodings)
            }
            Err(e) => {
                let folcername = SystemTime::now()
                    .duration_since(UNIX_EPOCH)
                    .expect("Time went backwards")
                    .as_secs();

                fs::create_dir_all(format!(
                    "{}/compilation_errors/ts/{}",
                    self.output_folder, folcername
                ))
                .unwrap();

                let mut file = fs::File::create(format!(
                    "{}/compilation_errors/ts/{}/log.txt",
                    self.output_folder, folcername
                ))
                .unwrap();

                file.write_all(e.to_string().as_bytes()).unwrap();

                let ts_code = fs::read_to_string(OUTPUT_PATH).unwrap();

                let mut code_file = fs::File::create(format!(
                    "{}/compilation_errors/ts/{}/index.ts",
                    self.output_folder, folcername
                ))
                .unwrap();

                code_file.write_all(ts_code.as_bytes()).unwrap();

                warn!("Failed to run Typescript: {:?}", e);

                // Return empty vec as the compilation failed
                return (vec![], vec![]);
            }
        }
    }

    fn extract_encodings(&self, string: &String) -> Vec<Encoding> {
        debug!("Extracting TS encodings from: {:?}", string);
        let mut encodings = Vec::new();
        let mut remaining = string.clone();

        while let Some(start) = remaining.find("Encoding") {
            if let Some(array_start) = remaining[start..].find('[') {
                if let Some(array_end) = remaining[start..].find(']') {
                    let array_str = &remaining[start + array_start + 1..start + array_end];

                    let encoding = array_str
                        .split(',')
                        .map(|s| s.trim().parse::<u8>().expect("Failed to parse u8"))
                        .collect::<Vec<u8>>();

                    encodings.push(encoding);
                    remaining = remaining[start + array_end + 1..].to_string();
                }
            }
        }
        encodings
    }

    fn extract_decodings(&self, string: &String) -> Vec<bool> {
        // info!("Extracting TS decodings from: {:?}", string);
        let mut decodings = Vec::new();
        let mut remaining = string.clone();

        while let Some(start) = remaining.find("Decoding") {
            if let Some(array_start) = remaining[start..].find('[') {
                if let Some(array_end) = remaining[start..].find(']') {
                    let array_str = &remaining[start + array_start + 1..start + array_end];

                    // Decoding[] contains a single boolean
                    let decoding = array_str
                        .trim()
                        .parse::<bool>()
                        .expect("Failed to parse bool");

                    decodings.push(decoding);
                    remaining = remaining[start + array_end + 1..].to_string();
                }
            }
        }
        decodings
    }

    fn run_typescript(&self) -> Result<String, ABIProbeError> {
        let command = format!(
            "cd {TS_SDK} && source $HOME/.nvm/nvm.sh && nvm use v20 && npx ts-node index.ts"
        );

        let output = std::process::Command::new("bash")
            .arg("-c")
            .arg(command)
            .output()
            .expect("failed to execute process");

        debug!(
            "Typescript stderr: {:?}",
            String::from_utf8_lossy(&output.stderr)
        );

        if !output.stderr.is_empty() {
            return Err(ABIProbeError::TypescriptCompilationError(
                String::from_utf8_lossy(&output.stderr).to_string(),
            ));
        }

        Ok(String::from_utf8_lossy(&output.stdout).to_string())
    }
}

#[cfg(test)]
mod tests {
    use fuels::types::param_types::EnumVariants;

    use super::*;
    type P = ParamType;
    type T = Token;

    #[test]
    fn test_convert_and_run_typescript_vec_u8() {
        let ts = Ts::new(&"output".to_string());
        let param_type = P::Vector(Box::new(P::U8));
        let token: T = T::Vector(vec![T::U8(1), T::U8(2)]);
        let samples = vec![(param_type, vec![token])];
        let mut converter = TSConverter::new();
        let src = converter.convert_to_src(&samples);
        info!("{src}");

        let mut file = fs::File::create(OUTPUT_PATH).unwrap();
        file.write_all(src.as_bytes()).unwrap();
        let res = ts.run_typescript();
        info!("{res:?}");
        res.unwrap();
    }

    #[test]
    fn test_convert_and_run_typescript_vec_u64() {
        let ts = Ts::new(&"output".to_string());
        let param_type: ParamType = P::Vector(Box::new(P::U64));
        let token: T = T::Vector(vec![T::U64(1), T::U64(2)]);
        let samples = vec![(param_type, vec![token])];
        let mut converter = TSConverter::new();
        let src = converter.convert_to_src(&samples);
        info!("{src}");

        let mut file = fs::File::create(OUTPUT_PATH).unwrap();
        file.write_all(src.as_bytes()).unwrap();
        let res = ts.run_typescript();
        info!("{res:?}");
        res.unwrap();
    }

    #[test]
    fn test_run_typescript_only() {
        let ts = Ts::new(&"output".to_string());
        ts.run_typescript().unwrap();
    }

    #[test]
    fn test_exercise_abi_vector() {
        let ts = Ts::new(&"output".to_string());
        let param_type = P::Vector(Box::new(P::U64));
        let token: T = T::Vector(vec![T::U64(1), T::U64(2)]);
        let samples = vec![(param_type, vec![token])];
        ts.exercise_abi(&samples);
    }

    #[test]
    fn test_exercise_abi_enum_unit() {
        let ts = Ts::new(&"output".to_string());
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
        ts.exercise_abi(&samples);
    }
}
