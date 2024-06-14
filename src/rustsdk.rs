use fuels::core::codec::{ABIDecoder, ABIEncoder};
use fuels::types::{param_types::ParamType, Token};
use tracing::{debug, info};

use crate::{error::ABIProbeError, Encoding};

fn rust_sdk_encoding_decoding(
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

pub fn exercise_abi(samples: &Vec<(ParamType, Vec<Token>)>) -> (Vec<Encoding>, Vec<bool>) {
    let mut rust_encodings = Vec::new();
    let mut rust_decodings = Vec::new();

    for sample in samples {
        let (param_type, tokens) = sample;

        for token in tokens.into_iter() {
            let (rust_encoding, rust_decoding) = rust_sdk_encoding_decoding(&token, &param_type);
            rust_encodings.push(rust_encoding);

            // If there is a token, push true, else push false
            match rust_decoding {
                Ok(_) => rust_decodings.push(true),
                Err(_) => rust_decodings.push(false),
            }
        }
    }
    (rust_encodings, rust_decodings)
}
