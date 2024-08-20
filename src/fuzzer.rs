use std::{
    fs,
    io::Write,
    time::{SystemTime, UNIX_EPOCH},
};

use fuels::types::{param_types::ParamType, Token};
use serde::{Deserialize, Serialize};
use tracing::{debug, error, info, warn};

use crate::{rustsdk::{self, RustSDK}, sampler::Sampler, sway::Sway, tssdk::Ts};

pub struct Fuzzer {
    sampler: Sampler,
    rounds: u32,
    samples: usize,
    round: u32,
    output_folder: String,
    sway: Sway,
    ts: Ts,
    rustsdk: RustSDK,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct LogOutput {
    param_type: ParamType,
    token: Token,
}

const SWAY_CODE_PATH: &str = "./forc_project/src/main.sw";
const TS_CODE_PATH: &str = "./ts-sdk/index.ts";

impl Fuzzer {
    pub fn new(sampler: Sampler, rounds: u32, samples: usize, output_folder: String) -> Self {
        // Create decoding error folder
        fs::create_dir_all(format!("{}/decoding_errors/", &output_folder)).unwrap();
        // Create one folder for each language
        fs::create_dir_all(format!("{}/decoding_errors/rust", &output_folder)).unwrap();
        fs::create_dir_all(format!("{}/decoding_errors/sway", &output_folder)).unwrap();
        fs::create_dir_all(format!("{}/decoding_errors/ts", &output_folder)).unwrap();

        //Create if not exists encoding_missmatches folder
        fs::create_dir_all(format!("{}/encoding_missmatches", &output_folder)).unwrap();

        //Create if not exists compilation_errors folder
        fs::create_dir_all(format!("{}/compilation_errors", &output_folder)).unwrap();

        fs::create_dir_all(format!("{}/decoding_missmatches/", output_folder)).unwrap();

        Self {
            sampler,
            rounds,
            samples,
            round: 0,
            sway: Sway::new(&output_folder),
            ts: Ts::new(&output_folder),
            rustsdk: RustSDK::new(&output_folder),
            output_folder,
        }
    }

    pub fn fuzz(&mut self) {
        for i in 0..self.rounds {
            info!("Fuzzing round: {:?}", i);
            self.fuzz_round();
        }
    }

    fn check_decodings(
        &mut self,
        samples: &Vec<(ParamType, Vec<Token>)>,
        decodings: Vec<bool>,
        dir: String,
    ) {
        if decodings.len() == 0 {
            // No decodings generated
            return;
        }

        for (i, decoding) in decodings.iter().enumerate() {
            if !decoding {
                info!("Decoding failed at index: {:?} for {}", i, dir);
                let foldername = SystemTime::now()
                    .duration_since(UNIX_EPOCH)
                    .expect("Time went backwards")
                    .as_secs();

                // Create a folder for the decoding error
                fs::create_dir_all(format!(
                    "{}/decoding_errors/{}/{}",
                    self.output_folder, dir, foldername
                ))
                .unwrap();

                // Log the samples
                let param_type_json = serde_json::to_string(&samples[i].0).unwrap();
                std::fs::write(
                    format!(
                        "{}/decoding_errors/{}/{}/param_type.json",
                        self.output_folder, dir, foldername
                    ),
                    param_type_json,
                )
                .expect("Unable to write file");

                let token_json = serde_json::to_string(&samples[i].1[0]).unwrap();
                std::fs::write(
                    format!(
                        "{}/decoding_errors/{}/{}/token.json",
                        self.output_folder, dir, foldername
                    ),
                    token_json,
                )
                .expect("Unable to write file");

                match dir.as_str() {
                    "rust" => {
                        // Skip, everything is inside the log
                    }
                    "sway" => {
                        let sway_code = fs::read_to_string(SWAY_CODE_PATH).unwrap();
                        let mut code_file = fs::File::create(format!(
                            "{}/decoding_errors/{}/{}/main.sw",
                            self.output_folder, dir, foldername
                        ))
                        .unwrap();
                        code_file.write_all(sway_code.as_bytes()).unwrap();
                    }
                    "ts" => {
                        let ts_code = fs::read_to_string(TS_CODE_PATH).unwrap();
                        let mut code_file = fs::File::create(format!(
                            "{}/decoding_errors/{}/{}/index.ts",
                            self.output_folder, dir, foldername
                        ))
                        .unwrap();
                        code_file.write_all(ts_code.as_bytes()).unwrap();
                    }
                    _ => {
                        panic!("Invalid dir");
                    }
                }
            }
        }
    }

    fn fuzz_round(&mut self) {
        let samples = self.sampler.sample(self.samples); // The size of a batch
        debug!("Sampled: {:?}", samples);

        let (rust_encodings, rust_decodings) = self.rustsdk.exercise_abi(&samples);
        let (sway_encodings, sway_decodings) = self.sway.exercise_abi(&samples);
        let (ts_encodings, ts_decodings) = self.ts.exercise_abi(&samples);

        // Reduce decodings, for [[true, false ], [true, true, true], [true], [false]] -> [false, true, true, false], if there is a false in the array reduce to false, else true, so this reduces with an AND
        //Reduce Vec<Vec<bool>> to Vec<bool>
        let reduced_sway_decodings = sway_decodings
            .iter()
            .map(|v| v.iter().fold(true, |acc, x| acc && *x))
            .collect();

        // Check Decodings, empty decodings are ignored (when encoding failed)
        self.check_decodings(&samples, rust_decodings, "rust".to_string());
        self.check_decodings(&samples, reduced_sway_decodings, "sway".to_string());
        self.check_decodings(&samples, ts_decodings, "ts".to_string());

        if sway_encodings.len() == 0 || rust_encodings.len() == 0 || ts_encodings.len() == 0 {
            warn!("Failed to generate encodings for all 3 languages, please consult the output logs for more information.");
            self.round += 1;
            // NOTE maybe do binary search to find the failing ParamType/Token that compiles
            return; // Go to next fuzzing loop, indiviudal crate will have logged the error
        }

        // Compare Encodings

        assert!(
            sway_encodings.len() == rust_encodings.len()
                && rust_encodings.len() == ts_encodings.len(),
            "Mismatch in the number of encodings"
        ); // Sanity check

        let samples_iter = samples
            .iter()
            .flat_map(|(pt, ts)| ts.iter().map(move |t| (pt, t)));

        // Compare the sway encodings with the rust encodings
        for (i, ((rust_encoding, sway_encoding, ts_encoding), param_token)) in rust_encodings
            .iter()
            .zip(sway_encodings.iter())
            .zip(ts_encodings.iter())
            .map(|((r, s), t)| (r, s, t))
            .zip(samples_iter)
            .enumerate()
        {
            let rust_ts_mismatch = rust_encoding != ts_encoding;
            let rust_sway_mismatch = rust_encoding != sway_encoding;
            let sway_ts_mismatch = sway_encoding != ts_encoding;

            // Find encoding missmatches
            if rust_sway_mismatch || rust_ts_mismatch || sway_ts_mismatch {
                info!("Mismatch at index: {:?}", i);
                debug!("Rust Encoding: {:?}", rust_encoding);
                debug!("Sway Encoding: {:?}", sway_encoding);
                debug!("TS Encoding: {:?}", ts_encoding);

                let foldername = SystemTime::now()
                    .duration_since(UNIX_EPOCH)
                    .expect("Time went backwards")
                    .as_secs();

                // Create a folder for the encoding missmatch
                fs::create_dir_all(format!(
                    "{}/encoding_missmatches/{}",
                    self.output_folder, foldername
                ))
                .unwrap();

                // Log into output/encoding_missmatches folder
                let mut file = fs::File::create(format!(
                    "{}/encoding_missmatches/{}/log.json",
                    self.output_folder, foldername
                ))
                .unwrap();
                let json = serde_json::json!({
                    "rust_encoding": rust_encoding,
                    "sway_encoding": sway_encoding,
                    "ts_encoding": ts_encoding,
                    "missmatch_type" : {
                        "rust-sway-missmatch" : rust_sway_mismatch,
                        "rust-ts-missmatch" : rust_ts_mismatch,
                        "sway-ts-missmatch" : sway_ts_mismatch,
                    },
                });
                file.write_all(json.to_string().as_bytes()).unwrap();

                let sway_code = fs::read_to_string(SWAY_CODE_PATH).unwrap();
                let mut sway_code_file = fs::File::create(format!(
                    "{}/encoding_missmatches/{}/main.sw",
                    self.output_folder, foldername
                ))
                .unwrap();
                sway_code_file.write_all(sway_code.as_bytes()).unwrap();

                let ts_code = fs::read_to_string(TS_CODE_PATH).unwrap();
                let mut ts_code_file = fs::File::create(format!(
                    "{}/encoding_missmatches/{}/index.ts",
                    self.output_folder, foldername
                ))
                .unwrap();
                ts_code_file.write_all(ts_code.as_bytes()).unwrap();

                let param_type_json = serde_json::to_string(&param_token.0).unwrap();
                std::fs::write(
                    format!(
                        "{}/encoding_missmatches/{}/param_type.json",
                        self.output_folder, foldername
                    ),
                    param_type_json,
                )
                .expect("Unable to write file");

                let token_json = serde_json::to_string(&param_token.1).unwrap();
                std::fs::write(
                    format!(
                        "{}/encoding_missmatches/{}/token.json",
                        self.output_folder, foldername
                    ),
                    token_json,
                )
                .expect("Unable to write file");
            }
        }

        self.round += 1;
    }
}
