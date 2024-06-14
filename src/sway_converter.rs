use fuels::types::{param_types::ParamType, Token};
use std::vec;
use tracing::{debug, info};

pub struct SwayConverter {
    vector_counter: usize,
    bytes_counter: usize,
    raw_slice_counter: usize,
    template: &'static str,
}

const CUSTOM_TYPES: &str = "{custom_types}";
const TESTCASES: &str = "{testcases}";

impl SwayConverter {
    pub fn new() -> Self {
        Self {
            vector_counter: 0,
            bytes_counter: 0,
            raw_slice_counter: 0,
            template: include_str!("../templates/template.sw"),
        }
    }

    pub fn convert_to_src(&mut self, samples: &Vec<(ParamType, Vec<Token>)>) -> String {
        let mut custom_types = String::new();
        let mut testcases = String::new();

        for sample in samples {
            let (param_type, tokens) = sample;

            for token in tokens {
                // Generate sway code
                let (sway_code_string, sway_type_declaration_str) =
                    self.generate_sway_encode_decode_string(&token, &param_type);

                testcases.push_str(&sway_code_string);
                custom_types.push_str(&sway_type_declaration_str);
                testcases.push_str("\n");
            }
        }

        self.template
            .replace(CUSTOM_TYPES, &custom_types)
            .replace(TESTCASES, &testcases)
    }

    pub fn convert_testcase(
        &mut self,
        token: &Token,
        param_type: &ParamType,
    ) -> (String, String, String, String) {
        match token {
            _ => {
                let type_str = self.get_type(param_type);
                let (value_str, prefix_str) = self.get_value(token, param_type);
                let type_declaration_str = self.get_declaration(param_type);
                // Extract struct informations from paramType

                (
                    format!("let v: {} = {};", type_str, value_str),
                    type_str,
                    prefix_str.join("\n"),
                    type_declaration_str,
                )
            }
        }
    }

    pub fn generate_sway_encode_decode_string(
        &mut self,
        token: &Token,
        param_type: &ParamType,
    ) -> (String, String) {
        // Generate sway code for encoding and decoding
        let (sway_variable_str, sway_type_str, sway_prefix_str, sway_type_declaration_str) =
            self.convert_testcase(token, param_type);

        let decoded_checks: Vec<_> = self
            .get_getters("v".to_string(), param_type, token)
            .into_iter()
            .zip(
                self.get_getters("decoded".to_string(), param_type, token)
                    .into_iter(),
            )
            .map(|(v, decoded)| format!("log({v} == {decoded});"))
            .collect();

        // if decoded_assertions.is_empty() {
        //     decoded_assertions = vec!["assert(v == decoded);".to_string()];
        // }

        let decoded_checks = decoded_checks.join("\n\t");

        debug!("Sway variable: {:?}", sway_variable_str);
        debug!("Sway type: {:?}", sway_type_str);
        debug!("Sway prefix: {:?}", sway_prefix_str);
        debug!("Sway declaration: {:?}", sway_type_declaration_str);

        // Format on multi line
        (
            format!(
                r#"{sway_prefix_str}    

    {sway_variable_str}
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<{sway_type_str}>(encoded);
    {decoded_checks}"#
            ),
            sway_type_declaration_str,
        )
    }

    pub fn get_type(&mut self, param_type: &ParamType) -> String {
        match param_type {
            ParamType::Unit => "()".to_string(),
            ParamType::Bool => "bool".to_string(),
            ParamType::U8 => "u8".to_string(),
            ParamType::U16 => "u16".to_string(),
            ParamType::U32 => "u32".to_string(),
            ParamType::U64 => "u64".to_string(),
            ParamType::U128 => "u128".to_string(),
            ParamType::U256 => "u256".to_string(),
            ParamType::B256 => "b256".to_string(),
            ParamType::Bytes => "Bytes".to_string(),
            ParamType::String => {
                "String".to_string() // Handle like a string slice for now // String::new()
            }
            ParamType::RawSlice => "raw_slice".to_string(),
            ParamType::StringArray(size) => format!("str[{}]", size),
            ParamType::StringSlice => "str".to_string(),
            ParamType::Tuple(types) => {
                let values: Vec<String> = types.iter().map(|p| self.get_type(p)).collect();
                format!("({})", values.join(", "))
            }
            ParamType::Array(element_type, size) => {
                let string_element_type = self.get_type(element_type);
                format!("[{}; {}]", string_element_type, size)
            }
            ParamType::Vector(element_type) => {
                let string_element_type = self.get_type(element_type);
                format!("Vec<{}>", string_element_type)
            }
            ParamType::Struct {
                name,
                fields: _,
                generics: _,
            } => name.clone(),
            ParamType::Enum {
                name,
                enum_variants: _,
                generics: _,
            } => name.clone(),
        }
    }

    fn get_value(&mut self, token: &Token, param_type: &ParamType) -> (String, Vec<String>) {
        match token {
            Token::Unit => ("()".to_string(), Vec::new()),
            Token::Bool(val) => (val.to_string(), Vec::new()),
            Token::U8(val) => (format!("{}u8", val), Vec::new()),
            Token::U16(val) => (val.to_string(), Vec::new()),
            Token::U32(val) => (val.to_string(), Vec::new()),
            Token::U64(val) => (val.to_string(), Vec::new()),
            Token::U128(val) => (val.to_string(), Vec::new()),
            Token::U256(val) => {
                // Convert value to hex string and append u256 at the end
                (format!("0x{:x}u256", val), Vec::new())
            }
            Token::B256(val) => (format!("0x{}", hex::encode(val)), Vec::new()),
            Token::Bytes(val) => {
                let bytes_name = self.next_bytes_name();
                let declaration =
                    self.generate_bytes_declaration(bytes_name.clone(), val, param_type);
                (bytes_name, declaration)
            }
            Token::String(val) => {
                (
                    format!("String::from_ascii_str(\"{}\")", val.to_string()),
                    Vec::new(),
                ) // Handle like a string slice for now
            }
            Token::RawSlice(val) => {
                let raw_slice_name = self.next_raw_slice_name();
                let declaration = self.generate_raw_slice_declaration(raw_slice_name.clone(), val);

                (raw_slice_name, declaration)
            }
            Token::StringArray(val) => {
                let data = val.get_encodable_str().unwrap();
                (format!(r#"__to_str_array("{}")"#, data), Vec::new())
            }
            Token::StringSlice(val) => (
                format!(r#""{}""#, val.get_encodable_str().unwrap().to_string()),
                Vec::new(),
            ),
            Token::Tuple(tokens) => {
                let ParamType::Tuple(types) = param_type else {
                    panic!("Tuple token without tuple param type")
                };
                let zip = tokens.iter().zip(types.iter());
                let all_values: Vec<(String, Vec<String>)> =
                    zip.map(|(t, p)| self.get_value(t, p)).collect();

                //unzip all values
                let (values, decls): (Vec<String>, Vec<Vec<String>>) =
                    all_values.iter().cloned().unzip();

                (
                    format!("({})", values.join(", ")),
                    decls.into_iter().flatten().collect(),
                )
            }
            Token::Array(tokens) => {
                let ParamType::Array(element_type, _size) = param_type else {
                    panic!("Array token without array param type")
                };
                let (values, decls): (Vec<String>, Vec<Vec<String>>) = tokens
                    .iter()
                    .map(|t| self.get_value(t, element_type))
                    .unzip();
                (
                    format!("[{}]", values.join(", ")),
                    decls.into_iter().flatten().collect(),
                )
            }
            Token::Vector(tokens) => {
                let ParamType::Vector(element_type) = param_type else {
                    panic!("Vector token without vector param type")
                };
                let vector_name = self.next_vector_name();
                let declaration =
                    self.generate_vector_declaration(vector_name.clone(), &tokens, &element_type);
                (vector_name, declaration)
            }
            Token::Struct(tokens) => {
                let ParamType::Struct { name, fields, .. } = param_type else {
                    panic!("Struct token without struct param type")
                };
                let mut declaration = Vec::new();
                let mut code = format!("{} {{", name);
                for (i, token) in tokens.iter().enumerate() {
                    let (field_value, decl) = self.get_value(token, &fields[i].1);
                    declaration.extend(decl);
                    let field_name = &fields[i].0;
                    code.push_str(&format!("{} : {},", field_name, field_value));
                }
                code.push_str("}");

                (code, declaration)
            }

            Token::Enum(selector) => {
                let ParamType::Enum {
                    name,
                    enum_variants,
                    generics: _,
                } = param_type
                else {
                    panic!("Enum token without enum param type")
                };
                let mut prefixes = Vec::new();

                let variant_str = enum_variants.variants()[usize::try_from(selector.0).unwrap()]
                    .0
                    .clone();

                let enum_variant_type =
                    &enum_variants.variants()[usize::try_from(selector.0).unwrap()].1;
                let (value_str, prefix) = self.get_value(&selector.1, enum_variant_type);
                prefixes.extend(prefix);
                match enum_variant_type {
                    ParamType::Unit => (format!("{}::{}", name, variant_str), prefixes),
                    _ => (
                        format!("{}::{}({})", name, variant_str, value_str),
                        prefixes,
                    ),
                }
            }
        }
    }

    fn generate_vector_declaration(
        &mut self,
        name: String,
        tokens: &Vec<Token>,
        param_type: &ParamType,
    ) -> Vec<String> {
        let mut declaration = Vec::new();
        let mut code = format!(
            "\tlet mut {} : Vec<{}> = Vec::new();",
            name,
            self.get_type(param_type)
        );
        for token in tokens {
            let (value, decl) = self.get_value(&token, param_type);
            // Add every item of decl if not empty to declaration
            declaration.extend(decl);
            code.push_str(&format!("\n\t{}.push({});", name, value));
        }
        code.push_str("\n");
        declaration.push(code);
        declaration
    }

    fn generate_bytes_declaration(
        &mut self,
        name: String,
        values: &Vec<u8>,
        param_type: &ParamType,
    ) -> Vec<String> {
        let _ = param_type;
        let mut declaration = Vec::new();
        let mut code = format!("\tlet mut {} = Bytes::new();", name);
        for v in values {
            code.push_str(&format!("\n\t{}.push({});", name, format!("{}u8", v)));
        }
        code.push_str("\n");
        declaration.push(code);
        declaration
    }

    fn generate_raw_slice_declaration(&mut self, name: String, values: &Vec<u8>) -> Vec<String> {
        // Generate bytes
        let mut declaration = Vec::new();
        let bytes_name = self.next_bytes_name();
        let mut bytes_declaration =
            self.generate_bytes_declaration(bytes_name.clone(), values, &ParamType::Bytes);

        // Add a new line to the end of the bytes declaration
        bytes_declaration.push(format!("\tlet {} = {}.as_raw_slice();\n", name, bytes_name));
        declaration.extend(bytes_declaration);
        declaration
    }

    fn get_getters(
        &mut self,
        var_name: String,
        param_type: &ParamType,
        token: &Token,
    ) -> Vec<String> {
        match param_type {
            ParamType::Unit => vec![var_name],
            ParamType::Bool => vec![var_name],
            ParamType::U8 => vec![var_name],
            ParamType::U16 => vec![var_name],
            ParamType::U32 => vec![var_name],
            ParamType::U64 => vec![var_name],
            ParamType::U128 => vec![var_name],
            ParamType::U256 => vec![var_name],
            ParamType::B256 => vec![var_name],
            ParamType::Bytes => vec![var_name],
            ParamType::String => vec![var_name],
            ParamType::RawSlice => vec![format!("Bytes::from({})", var_name)],
            ParamType::StringArray(_) => vec![format!("from_str_array({})", var_name)],
            ParamType::StringSlice => vec![var_name],
            ParamType::Tuple(types) => {
                let mut getters = vec![];
                let tuple_token = match token {
                    Token::Tuple(tokens) => tokens,
                    _ => panic!("Token does not match param type"),
                };
                for (i, t) in types.iter().enumerate() {
                    let sub_getters: Vec<_> =
                        self.get_getters(format!("{}.{}", var_name, i), t, &tuple_token[i]);

                    getters.extend(sub_getters.into_iter());
                }
                return getters;
            }
            ParamType::Array(element_type, _size) => {
                let mut getters = vec![];
                let array_token = match token {
                    Token::Array(tokens) => tokens,
                    _ => panic!("Token does not match param type"),
                };
                for (i, t) in array_token.iter().enumerate() {
                    let sub_getters: Vec<_> =
                        self.get_getters(format!("{}[{}]", var_name, i), &element_type, t);

                    getters.extend(sub_getters.into_iter());
                }
                return getters;
            }
            ParamType::Vector(element_type) => {
                let mut getters = vec![];
                let vector_token = match token {
                    Token::Vector(tokens) => tokens,
                    _ => {
                        panic!("Token does not match param type")
                    }
                };
                for (i, t) in vector_token.iter().enumerate() {
                    let sub_getters: Vec<_> = self.get_getters(
                        format!("{}.get({}).unwrap()", var_name, i),
                        &element_type,
                        t,
                    );

                    getters.extend(sub_getters.into_iter());
                }
                return getters;
            }
            ParamType::Struct { fields, .. } => {
                let mut getters = vec![];
                let struct_token = match token {
                    Token::Struct(tokens) => tokens,
                    _ => panic!("Token does not match param type"),
                };
                for (i, (n, t)) in fields.iter().enumerate() {
                    let sub_getters: Vec<_> =
                        self.get_getters(format!("{}.{}", var_name, n), t, &struct_token[i]);

                    getters.extend(sub_getters.into_iter());
                }
                return getters;
            }
            ParamType::Enum { .. } => {
                let Token::Enum(enum_selector) = token else {
                    unreachable!()
                };
                let (index, inner_token, enum_variants) = enum_selector.as_ref();
                let (variant_name, variant_type) = enum_variants.select_variant(*index).unwrap();
                self.get_getters(
                    format!("{var_name}.get_{variant_name}()"),
                    variant_type,
                    inner_token,
                )
            }
        }
    }

    fn next_vector_name(&mut self) -> String {
        let name = format!("vector{}", self.vector_counter);
        self.vector_counter += 1;
        name
    }

    fn next_bytes_name(&mut self) -> String {
        let name = format!("bytes{}", self.bytes_counter);
        self.bytes_counter += 1;
        name
    }

    fn next_raw_slice_name(&mut self) -> String {
        let name = format!("raw_slice{}", self.raw_slice_counter);
        self.raw_slice_counter += 1;
        name
    }

    fn get_declaration(&mut self, param_type: &ParamType) -> String {
        match param_type {
            ParamType::Tuple(element_types) => {
                let mut declarations: Vec<String> = Vec::new();
                for element_type in element_types {
                    let element_declaration = self.get_declaration(element_type);
                    declarations.push(element_declaration);
                }
                declarations.retain(|x| !x.is_empty());
                declarations.join("\n")
            }

            ParamType::Array(element_type, _size) => self.get_declaration(element_type),

            ParamType::Vector(element_type) => self.get_declaration(element_type),

            ParamType::Struct {
                name,
                fields,
                generics: _,
            } => {
                let mut code = format!("struct {} {{\n", name);
                let mut declarations: Vec<String> = Vec::new();
                for (field_name, field_type) in fields {
                    let field_declaration = self.get_declaration(field_type);
                    declarations.push(field_declaration);
                    code.push_str(&format!(
                        "\t{} : {},\n",
                        field_name,
                        self.get_type(field_type)
                    ));
                }
                code.push_str("}\n");
                declarations.push(code);

                // Remove all empty strings
                declarations.retain(|x| !x.is_empty());
                declarations.join("\n")
            }

            ParamType::Enum {
                name,
                enum_variants,
                ..
            } => {
                let mut code = format!("enum {} {{\n", name);
                let mut declarations: Vec<String> = Vec::new();

                for (variant_name, variant_type) in enum_variants.variants().iter() {
                    let variant_declaration = self.get_declaration(variant_type);
                    declarations.push(variant_declaration);
                    code.push_str(&format!(
                        "\t{} : {},\n",
                        variant_name,
                        self.get_type(variant_type)
                    ));
                }

                code.push_str("}\n");
                declarations.push(code);

                // Remove all empty strings
                declarations.retain(|x| !x.is_empty());

                let mut getters = vec![];
                for (variant_name, variant_type) in enum_variants.variants() {
                    let variant_inner_type = self.get_type(variant_type);

                    let getter = if !matches!(variant_type, ParamType::Unit) {
                        format!(
                            r#"fn get_{variant_name}(self) -> {variant_inner_type} {{
        match self {{
            {name}::{variant_name}(v) => v,
            _ => revert(0),
        }}
    }}"#
                        )
                    } else {
                        format!(
                            r#"fn get_{variant_name}(self) -> bool {{
        match self {{
            {name}::{variant_name}(v) => true,
            _ => revert(0),
        }}
    }}"#
                        )
                    };
                    getters.push(getter);
                }
                let joined_getters = getters.join("\n");
                let getters = format!(
                    r#"impl {name} {{
    {joined_getters}
}}"#
                );
                declarations.push(getters);
                declarations.join("\n")
            }

            _ => "".to_string(), // All other cases there is not declaration needed
        }
    }
}

#[cfg(test)]
mod test {
    use super::*;
    use fuels::types::{
        param_types::{self, EnumVariants, ParamType},
        StaticStringToken, U256,
    };

    type P = ParamType;
    type T = Token;

    #[test]
    fn convert_primitive_types() {
        let mut converter = SwayConverter::new();
        let types = vec![
            ParamType::Unit,
            ParamType::Bool,
            ParamType::U8,
            ParamType::U16,
            ParamType::U32,
            ParamType::U64,
            ParamType::U256,
            ParamType::B256,
            ParamType::String,
            ParamType::StringArray(3),
            ParamType::StringSlice,
        ];

        let tokens = vec![
            Token::Unit,
            Token::Bool(true),
            Token::U8(1),
            Token::U16(1),
            Token::U32(1),
            Token::U64(1),
            Token::U256(U256::from(1)),
            Token::B256([1; 32]),
            Token::String("Hello".to_string()),
            Token::StringArray(StaticStringToken::new("Hello".to_string(), Some(5))),
            Token::StringSlice(StaticStringToken::new("Hello".to_string(), Some(5))),
        ];

        let expected_results = vec![
            "let v: () = ();",
            "let v: bool = true;",
            "let v: u8 = 1u8;",
            "let v: u16 = 1;",
            "let v: u32 = 1;",
            "let v: u64 = 1;",
            "let v: u256 = 0x1u256;",
            "let v: b256 = 0x0101010101010101010101010101010101010101010101010101010101010101;",
            "let v: String = String::from_ascii_str(\"Hello\");",
            "let v: str[3] = __to_str_array(\"Hello\");",
            "let v: str = \"Hello\";",
        ];

        for (index, t) in types.iter().enumerate() {
            let token = &tokens[index];
            let (sway_variable_str, sway_type_str, sway_prefix_str, sway_type_declaration_str) =
                converter.convert_testcase(&token, &t);

            // dbg!(&index);
            // dbg!(&sway_variable_str);
            assert!(sway_variable_str == expected_results[index]);
            assert!(sway_prefix_str.len() == 0);
            assert!(sway_type_declaration_str.is_empty());
        }
    }

    #[test]
    fn convert_compound_type() {
        let mut converter = SwayConverter::new();
        let types = vec![
            ParamType::Tuple(vec![
                param_types::ParamType::U8,
                param_types::ParamType::Bool,
            ]),
            ParamType::Array(Box::new(param_types::ParamType::U8), 2),
            ParamType::Vector(Box::new(param_types::ParamType::U8)),
            ParamType::Struct {
                name: "TestStruct".to_string(),
                fields: vec![
                    ("field1".to_string(), param_types::ParamType::U8),
                    ("field2".to_string(), param_types::ParamType::Bool),
                ],
                generics: Vec::new(),
            },
            // ParamType::Enum {
            //     name: "TestEnum".to_string(),
            //     enum_variants: vec![("Variant1".to_string(), param_types::ParamType::U8), ("Variant2".to_string(), param_types::ParamType::Bool)],
            //     generics: Vec::new(),
            // },
        ];

        let tokens = vec![
            Token::Tuple(vec![Token::U8(1), Token::Bool(true)]),
            Token::Array(vec![Token::U8(1), Token::U8(2)]),
            Token::Vector(vec![Token::U8(1), Token::U8(2)]),
            Token::Struct(vec![Token::U8(1), Token::Bool(true)]),
            //Token::Enum("Variant1".to_string(), Token::U8(1)),
        ];

        let expected_results_variables = vec![
            "let v: (u8, bool) = (1u8, true);",
            "let v: [u8; 2] = [1u8, 2u8];",
            "let v: Vec<u8> = vector0;",
            "let v: TestStruct = TestStruct {field1 : 1u8,field2 : true,};",
        ];

        let expected_results_prefix = vec![
            "",
            "",
            "\tlet mut vector0 : Vec<u8> = Vec::new();\n\tvector0.push(1u8);\n\tvector0.push(2u8);\n",
            "",
        ];

        let expected_results_declaration = vec![
            "",
            "",
            "",
            "struct TestStruct {\n\tfield1 : u8,\n\tfield2 : bool,\n}\n",
        ];

        for (index, t) in types.iter().enumerate() {
            let token = &tokens[index];
            let (sway_variable_str, sway_type_str, sway_prefix_str, sway_type_declaration_str) =
                converter.convert_testcase(&token, &t);

            dbg!(index);
            dbg!(&sway_variable_str);
            dbg!(&sway_prefix_str);
            assert!(sway_variable_str == expected_results_variables[index]);
            assert!(sway_prefix_str == expected_results_prefix[index]);
            assert!(sway_type_declaration_str == expected_results_declaration[index]);
        }
    }

    #[test]
    fn nested_structs() {
        let mut converter = SwayConverter::new();

        let testStruct = ParamType::Struct {
            name: "TestStruct".to_string(),
            fields: vec![
                ("field1".to_string(), param_types::ParamType::U8),
                ("field2".to_string(), param_types::ParamType::Bool),
            ],
            generics: Vec::new(),
        };

        let testStruct1: ParamType = ParamType::Struct {
            name: "TestStruct1".to_string(),
            fields: vec![
                ("field1".to_string(), param_types::ParamType::U8),
                ("field2".to_string(), param_types::ParamType::Bool),
                ("field3".to_string(), testStruct.clone()),
            ],
            generics: Vec::new(),
        };

        let token = Token::Struct(vec![
            Token::U8(1),
            Token::Bool(true),
            Token::Struct(vec![Token::U8(1), Token::Bool(true)]),
        ]);

        let param_type = &testStruct1;

        let (sway_variable_str, sway_type_str, sway_prefix_str, sway_type_declaration_str) =
            converter.convert_testcase(&token, param_type);

        let expected_result_variable = "let v: TestStruct1 = TestStruct1 {field1 : 1,field2 : true,field3 : TestStruct {field1 : 1,field2 : true,},};";

        let expected_result_declaration = "struct TestStruct {\n\tfield1 : u8,\n\tfield2 : bool,\n}\n\nstruct TestStruct1 {\n\tfield1 : u8,\n\tfield2 : bool,\n\tfield3 : TestStruct,\n}\n";

        // assert!(expected_result_variable == sway_variable_str);
        // assert!(sway_prefix_str.len() == 0);
        // assert!(expected_result_declaration == sway_type_declaration_str);

        let samples = vec![(testStruct1, vec![token])];
        let src = converter.convert_to_src(&samples);
    }

    #[test]
    fn getters() {
        let mut converter = SwayConverter::new();

        let testStruct = ParamType::Struct {
            name: "TestStruct".to_string(),
            fields: vec![
                ("field1".to_string(), param_types::ParamType::U8),
                ("field2".to_string(), param_types::ParamType::Bool),
            ],
            generics: Vec::new(),
        };

        let testStructToken = Token::Struct(vec![Token::U8(1), Token::Bool(true)]);

        let testStruct1: ParamType = ParamType::Struct {
            name: "TestStruct1".to_string(),
            fields: vec![
                ("field1".to_string(), param_types::ParamType::U8),
                ("field2".to_string(), param_types::ParamType::Bool),
                ("field3".to_string(), testStruct.clone()),
            ],
            generics: Vec::new(),
        };

        let testStruct1Token = Token::Struct(vec![
            Token::U8(1),
            Token::Bool(true),
            testStructToken.clone(),
        ]);

        // for g in getters {
        //     info!("{}", &g);
        // }
    }

    #[test]
    fn enum_unit_src() {
        let vector_type = P::Vector(Box::new(P::U64));
        // let vector_token: Token = Token::Unit;
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

        let enum_token = Token::Enum(Box::new((1, Token::Unit, enum_variants.clone())));

        let mut converter = SwayConverter::new();

        let samples = vec![(enum_type, vec![enum_token])];

        let src = converter.convert_to_src(&samples);

        info!("{}", src);
    }

    #[test]
    fn enum_vec_src() {
        let vector_type = P::Vector(Box::new(P::U64));
        let vector_token: Token = Token::Vector(vec![Token::U64(1), Token::U64(2)]);
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

        let enum_token = Token::Enum(Box::new((0, vector_token, enum_variants.clone())));

        let mut converter = SwayConverter::new();

        let samples = vec![(enum_type, vec![enum_token])];

        let src = converter.convert_to_src(&samples);

        info!("{}", src);
    }
}
