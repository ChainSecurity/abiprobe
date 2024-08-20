use std::io::Write;
use std::{fs, process};
use std::time::{SystemTime, UNIX_EPOCH};

use fuels::core::codec::{ABIDecoder, ABIEncoder};
use fuels::types::output;
use fuels::types::{param_types::ParamType, Token};
use tracing::{debug, info, warn};

use crate::{error::ABIProbeError, Encoding};

pub struct RustSDK {
    output_folder: String,
}

impl RustSDK {
    pub fn new(output_folder: &String) -> Self {
        fs::create_dir_all(format!("{}/decoding_missmatches/rustsdk/", output_folder)).unwrap();
        Self {
            output_folder: output_folder.clone(),
        }
    }

    pub fn rust_sdk_encoding_decoding(
        token: &Token,
        param_type: &ParamType,
    ) -> (Vec<u8>, Result<Token, ABIProbeError>) {
        let encoding = ABIEncoder::default().encode(&[token.clone()]).unwrap();

        debug!("Rust Encoding: {:?}", encoding);

        let decoding = match ABIDecoder::default().decode(&param_type.clone(), &encoding.clone()) {
            Ok(tokens) => Ok(tokens.clone()),
            Err(e) => Err(ABIProbeError::RustSDKDecodingError(e.to_string())),
        };

        debug!("Rust Decoding: {:?}", decoding);

        (encoding, decoding)
    }

    pub fn exercise_abi(&self, samples: &Vec<(ParamType, Vec<Token>)>) -> (Vec<Encoding>, Vec<bool>) {
        let mut rust_encodings = Vec::new();
        let mut rust_decodings = Vec::new();

        for sample in samples {
            let (param_type, tokens) = sample;

            for token in tokens.into_iter() {
                let (rust_encoding, rust_decoding) = Self::rust_sdk_encoding_decoding(&token, &param_type);
                rust_encodings.push(rust_encoding);


                // If there is a token, push true, else push false
                match rust_decoding {
                    Ok(decoded_token) => {
                        // Compare rust_decoding with token
                        if token.clone() != decoded_token {
                            let foldername = SystemTime::now()
                                .duration_since(UNIX_EPOCH)
                                .expect("Time went backwards")
                                .as_secs();

                            fs::create_dir_all(format!(
                                "{}/decoding_missmatches/rustsdk/{}",
                                self.output_folder, foldername
                            ))
                            .unwrap();

                            let mut file = fs::File::create(format!(
                                "{}/decoding_missmatches/rustsdk/{}/log.txt",
                                self.output_folder, foldername
                            ))
                            .unwrap();
                            

                            // Write token
                            file.write_all(format!("Token: {:?}\n", token).as_bytes()).unwrap();

                            // new line
                            file.write_all("\n".as_bytes()).unwrap();

                            // Write decoded token
                            file.write_all(format!("Decoded Token: {:?}\n", decoded_token).as_bytes()).unwrap();
                            
                           
                            warn!("RustSDK missmatch between token and decoded token");

                        }

                        rust_decodings.push(true)
                    },
                    Err(_) => rust_decodings.push(false),
                }
            }
        }
        (rust_encodings, rust_decodings)
    }

}
