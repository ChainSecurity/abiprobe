use fuels::types::{
    param_types::{EnumVariants, ParamType},
    StaticStringToken, Token, U256,
};
use rand::{rngs::StdRng, Rng, SeedableRng};
use tracing::{debug, info};

const NUM_PRIMITIVE_TYPES: usize = 12;
const NUM_COMPOUND_TYPES: usize = 4;

#[derive(Debug)]
pub struct SamplerConfig {
    pub(crate) seed: u64,
    pub(crate) max_depth: usize,
    pub(crate) array_max_length: usize,
    pub(crate) array_min_length: usize,
    pub(crate) string_min_length: usize,
    pub(crate) string_max_length: usize,
    pub(crate) struct_min_fields: usize,
    pub(crate) struct_max_fields: usize,
    pub(crate) enum_min_variants: usize,
    pub(crate) enum_max_variants: usize,
    pub(crate) tuple_min_length: usize,
    pub(crate) tuple_max_length: usize,
    pub(crate) vector_min_length: usize,
    pub(crate) vector_max_length: usize,
    pub(crate) slice_min_length: usize,
    pub(crate) slice_max_length: usize,
    pub(crate) bytes_min_length: usize,
    pub(crate) bytes_max_length: usize,
}

#[derive(Debug)]
pub struct Sampler {
    rng: StdRng,
    config: SamplerConfig,
    struct_id: usize,
    enum_id: usize,
}

impl Sampler {
    pub fn new(config: SamplerConfig) -> Self {
        Self {
            rng: StdRng::seed_from_u64(config.seed),
            config,
            struct_id: 0,
            enum_id: 0,
        }
    }

    pub fn sample(&mut self, length: usize) -> Vec<(ParamType, Vec<Token>)> {
        let mut param_types = Vec::with_capacity(length);
        for _ in 0..length {
            let param_type = self.sample_type(0, false);
            param_types.push(param_type);
        }

        let mut ret = Vec::with_capacity(length);

        for param_type in param_types {
            let tokens = self.sample_token(&param_type); // NOTE we could generate multiple tokens from one type here, create sample_tokens
            ret.push((param_type, vec![tokens]));
        }

        ret
    }

    fn sample_types(
        &mut self,
        current_depth: usize,
        length: usize,
        in_enum: bool,
    ) -> Vec<ParamType> {
        let mut sampled_types: Vec<ParamType> = Vec::with_capacity(length);

        // if there is a length specified, generate that many tokens
        for _ in 0..length {
            let sampled_type = self.sample_type(current_depth, in_enum);
            sampled_types.push(sampled_type);
        }

        sampled_types
    }

    fn sample_type(&mut self, current_depth: usize, in_enum: bool) -> ParamType {
        let is_primitive = self.rng.gen_bool(0.5);

        if is_primitive || current_depth >= self.config.max_depth {
            self.sample_type_primitive_type(in_enum)
        } else {
            self.sample_compound_type(current_depth)
        }
    }

    fn sample_ascii_string(&mut self, min_length: usize, max_length: usize) -> String {
        // Determine the length of the string to generate
        let length = if min_length == max_length {
            min_length
        } else {
            self.rng.gen_range(min_length..=max_length)
        };

        debug!("Ascii Length: {:?}", length);

        // Generate random ASCII data
        let data: Vec<u8> = (0..length)
            .map(|_| self.rng.gen_range(0..=127)) // Full ASCII range
            .collect();

        // Convert to string
        let ascii_string = String::from_utf8(data).expect("Generated string is not valid UTF-8");
        debug!("Ascii String: {:?}", ascii_string);
        assert!(ascii_string.is_ascii(), "Generated string is not ASCII");

        let mut escaped_ascii_string = String::with_capacity(ascii_string.len() * 2);
        for c in ascii_string.chars() {
            // match c {
            //     '\\' => escaped_ascii_string.push_str("\\\\"),
            //     '\"' => escaped_ascii_string.push_str("\\\""),
            //     '\'' => escaped_ascii_string.push_str("\\'"),
            //     '\n' => escaped_ascii_string.push_str("\\n"),
            //     '\r' => escaped_ascii_string.push_str("\\r"),
            //     '\t' => escaped_ascii_string.push_str("\\t"),
            //     _ => escaped_ascii_string.push(c),
            // }

            // Due to https://github.com/FuelLabs/sway/issues/4993 we currently cannot use characters such as \n, \r, \t, etc. in the strings as they behave differently in Sway and in TS
            // Sway does not support \n as it will treat it as a two character string, while TS does support it.
            match c {
                '\\' => escaped_ascii_string.push_str("*"),
                '\"' => escaped_ascii_string.push_str("\\\""),
                '\'' => escaped_ascii_string.push_str("\\'"),
                '\n' => escaped_ascii_string.push_str("*"),
                '\r' => escaped_ascii_string.push_str("*"),
                '\t' => escaped_ascii_string.push_str("*"),
                _ => escaped_ascii_string.push(c),
            }
        }

        // Print the escaped ASCII string
        debug!("Escaped ASCII string: {:?}", escaped_ascii_string);

        debug!(
            "Escaped ASCII string length: {:?}",
            escaped_ascii_string.len()
        );

        escaped_ascii_string
    }

    fn sample_type_primitive_type(&mut self, in_enum: bool) -> ParamType {
        // Only allow ParamType::Unit to be part of the random generation if it is not part of an Enum
        let range = if in_enum {
            0..=NUM_PRIMITIVE_TYPES
        } else {
            1..=NUM_PRIMITIVE_TYPES
        };

        match self.rng.gen_range(range) {
            0 => ParamType::Unit,
            1 => ParamType::Bool,
            2 => ParamType::U8,
            3 => ParamType::U16,
            4 => ParamType::U32,
            5 => ParamType::U64,
            6 => ParamType::U256,
            7 => ParamType::B256,
            8 => ParamType::String,
            9 => {
                let length = self
                    .rng
                    .gen_range(self.config.string_min_length..=self.config.string_max_length);
                ParamType::StringArray(length)
            }
            10 => ParamType::StringSlice,
            11 => ParamType::Bytes,
            12 => ParamType::RawSlice,
            _ => unreachable!(),
        }
    }

    fn sample_compound_type(&mut self, current_depth: usize) -> ParamType {
        match self.rng.gen_range(0..=NUM_COMPOUND_TYPES) {
            0 => {
                let param_type = self.sample_type(current_depth + 1, false);
                let length = self
                    .rng
                    .gen_range(self.config.array_min_length..=self.config.array_max_length);
                ParamType::Array(Box::new(param_type), length)
            }
            1 => {
                let length = self
                    .rng
                    .gen_range(self.config.tuple_min_length..=self.config.tuple_max_length);
                let param_types = self.sample_types(current_depth + 1, length, false);
                ParamType::Tuple(param_types)
            }
            2 => {
                let param_type = self.sample_type(current_depth + 1, false);
                ParamType::Vector(Box::new(param_type))
            }
            3 => {
                let name = format!("Struct{}", self.next_struct_id());
                let length = self
                    .rng
                    .gen_range(self.config.struct_min_fields..=self.config.struct_max_fields);
                let fields_types = self.sample_types(current_depth + 1, length, false);
                let fields_names: Vec<String> = fields_types
                    .iter()
                    .enumerate()
                    .map(|(i, _param_type)| (format!("field{}", i + 1)))
                    .collect();
                let fields: Vec<(String, ParamType)> = fields_names
                    .into_iter()
                    .zip(fields_types.into_iter())
                    .collect();

                ParamType::Struct {
                    name,
                    fields,
                    generics: Vec::with_capacity(0),
                }
            }
            4 => {
                let name = format!("Enum{}", self.next_enum_id());
                let length = self
                    .rng
                    .gen_range(self.config.enum_min_variants..=self.config.enum_max_variants);
                let enum_types = self.sample_types(current_depth + 1, length, true);
                let enum_field_names: Vec<_> = enum_types
                    .iter()
                    .enumerate()
                    .map(|(i, _param_type)| (format!("Variant{}", i + 1)))
                    .collect();

                let enum_fields = enum_field_names
                    .into_iter()
                    .zip(enum_types.into_iter())
                    .collect();
                let enum_variants = EnumVariants::new(enum_fields).unwrap();

                ParamType::Enum {
                    name,
                    enum_variants,
                    generics: Vec::with_capacity(0),
                }
            }
            _ => unreachable!(),
        }
    }

    fn next_struct_id(&mut self) -> usize {
        let id = self.struct_id;
        self.struct_id += 1;
        id
    }

    fn next_enum_id(&mut self) -> usize {
        let id = self.enum_id;
        self.enum_id += 1;
        id
    }

    fn sample_token(&mut self, param_type: &ParamType) -> Token {
        match param_type {
            ParamType::Unit => Token::Unit,
            ParamType::Bool => Token::Bool(self.rng.gen_bool(0.5)),
            ParamType::U8 => Token::U8(self.rng.gen()),
            ParamType::U16 => Token::U16(self.rng.gen()),
            ParamType::U32 => Token::U32(self.rng.gen()),
            ParamType::U64 => Token::U64(self.rng.gen()),
            ParamType::U128 => Token::U64(self.rng.gen()),
            ParamType::U256 => {
                let high: u128 = self.rng.gen();
                let low: u128 = self.rng.gen();
                let value = (U256::from(high) << 128) | U256::from(low);
                Token::U256(value)
            }
            ParamType::B256 => Token::B256(self.rng.gen()),
            ParamType::String => {
                let ascii_string = self.sample_ascii_string(
                    self.config.string_min_length,
                    self.config.string_max_length,
                );
                Token::String(ascii_string)
            }
            ParamType::StringArray(length) => {
                let ascii_string = self.sample_ascii_string(*length, *length);
                let cloned_ascii_string = ascii_string.clone();
                Token::StringArray(StaticStringToken::new(
                    cloned_ascii_string,
                    Some(ascii_string.len()),
                ))
            }
            ParamType::StringSlice => {
                let ascii_string = self.sample_ascii_string(
                    self.config.string_min_length,
                    self.config.string_max_length,
                );
                let cloned_ascii_string = ascii_string.clone();
                Token::StringSlice(StaticStringToken::new(
                    cloned_ascii_string,
                    Some(ascii_string.len()),
                ))
            }
            ParamType::Bytes => {
                let length = self
                    .rng
                    .gen_range(self.config.bytes_min_length..=self.config.bytes_max_length);
                let data: Vec<u8> = (0..length).map(|_| self.rng.gen::<u8>()).collect();
                Token::Bytes(data)
            }

            ParamType::RawSlice => {
                let length = self
                    .rng
                    .gen_range(self.config.slice_min_length..=self.config.slice_max_length);
                let data: Vec<u8> = (0..length).map(|_| self.rng.gen::<u8>()).collect();
                Token::RawSlice(data)
            }

            ParamType::Tuple(param_types) => {
                let mut tokens = Vec::with_capacity(param_types.len());
                for param_type in param_types {
                    let token = self.sample_token(param_type);
                    tokens.push(token);
                }

                Token::Tuple(tokens)
            }

            ParamType::Array(param_type, length) => {
                let mut tokens = Vec::with_capacity(*length);
                for _ in 0..*length {
                    let token = self.sample_token(param_type); // Clone param_type
                    tokens.push(token);
                }
                Token::Array(tokens)
            }

            ParamType::Vector(param_type) => {
                let length = self
                    .rng
                    .gen_range(self.config.vector_min_length..=self.config.vector_max_length);
                let mut tokens = Vec::with_capacity(length);
                for _ in 0..length {
                    let token = self.sample_token(param_type); // Clone param_type
                    tokens.push(token);
                }
                Token::Vector(tokens)
            }

            ParamType::Struct {
                name: _,
                fields,
                generics: _,
            } => {
                let mut tokens = Vec::with_capacity(fields.len());
                for (_, field_type) in fields {
                    let token = self.sample_token(field_type);
                    tokens.push(token);
                }
                Token::Struct(tokens)
            }

            ParamType::Enum {
                name: _,
                enum_variants,
                generics: _,
            } => {
                let variant_index = self.rng.gen_range(0..enum_variants.variants().len()) as u64;
                let (_name, param_type) = enum_variants.select_variant(variant_index).unwrap();
                let token = self.sample_token(param_type);
                Token::Enum(Box::new((variant_index, token, enum_variants.clone())))
            }
        }
    }
}
