use thiserror::Error;

#[derive(Error, Debug)]
pub enum ABIProbeError {
    #[error("Sway command error: `{0}`")]
    SwayCommandError(String),
    #[error("Sway compilation error: `{0}`")]
    SwayCompilationError(String),

    #[error("Typescript compilation error: `{0}`")]
    TypescriptCompilationError(String),

    #[error("RustSDK decoding error: `{0}`")]
    RustSDKDecodingError(String),
}
