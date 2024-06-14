use serde::Deserialize;
use std::error::Error;
use std::fs;
use tracing::info;

#[derive(Debug, Deserialize, Clone)]
pub struct Config {
    pub config: Option<String>,
    pub seed: Option<u64>,
    pub rounds: Option<u32>,
    pub samples: Option<usize>,
    pub max_depth: Option<usize>,
    pub output_folder: Option<String>,
    pub array_min_len: Option<usize>,
    pub array_max_len: Option<usize>,
    pub string_min_len: Option<usize>,
    pub string_max_len: Option<usize>,
    pub struct_min_fields: Option<usize>,
    pub struct_max_fields: Option<usize>,
    pub enum_min_variants: Option<usize>,
    pub enum_max_variants: Option<usize>,
    pub tuple_min_len: Option<usize>,
    pub tuple_max_len: Option<usize>,
    pub vector_min_len: Option<usize>,
    pub vector_max_len: Option<usize>,
    pub slice_min_len: Option<usize>,
    pub slice_max_len: Option<usize>,
    pub bytes_min_len: Option<usize>,
    pub bytes_max_len: Option<usize>,
}

impl Config {
    pub fn merge_with_defaults(mut self, defaults: &Config) -> Config {
        self.config = self.config.or(defaults.config.clone());
        self.seed = self.seed.or(defaults.seed);
        self.rounds = self.rounds.or(defaults.rounds);
        self.samples = self.samples.or(defaults.samples);
        self.max_depth = self.max_depth.or(defaults.max_depth);
        self.output_folder = self.output_folder.or(defaults.output_folder.clone());
        self.array_min_len = self.array_min_len.or(defaults.array_min_len);
        self.array_max_len = self.array_max_len.or(defaults.array_max_len);
        self.string_min_len = self.string_min_len.or(defaults.string_min_len);
        self.string_max_len = self.string_max_len.or(defaults.string_max_len);
        self.struct_min_fields = self.struct_min_fields.or(defaults.struct_min_fields);
        self.struct_max_fields = self.struct_max_fields.or(defaults.struct_max_fields);
        self.enum_min_variants = self.enum_min_variants.or(defaults.enum_min_variants);
        self.enum_max_variants = self.enum_max_variants.or(defaults.enum_max_variants);
        self.tuple_min_len = self.tuple_min_len.or(defaults.tuple_min_len);
        self.tuple_max_len = self.tuple_max_len.or(defaults.tuple_max_len);
        self.vector_min_len = self.vector_min_len.or(defaults.vector_min_len);
        self.vector_max_len = self.vector_max_len.or(defaults.vector_max_len);
        self.slice_min_len = self.slice_min_len.or(defaults.slice_min_len);
        self.slice_max_len = self.slice_max_len.or(defaults.slice_max_len);
        self.bytes_min_len = self.bytes_min_len.or(defaults.bytes_min_len);
        self.bytes_max_len = self.bytes_max_len.or(defaults.bytes_max_len);
        self
    }
}

pub fn load_config(config_path: String) -> Result<Config, Box<dyn Error>> {
    let config_content = fs::read_to_string(config_path)?;
    let config: Config = toml::from_str(&config_content)?;
    info!("Config: {:?}", config);
    Ok(config)
}
