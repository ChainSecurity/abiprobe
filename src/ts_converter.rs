use fuels::types::{param_types::ParamType, Token};
use tracing::{debug, info};

const CUSTOM_TYPES: &str = "{custom_types}";
const TESTCASES: &str = "{testcases}";

pub struct TSConverter {
    template: &'static str,
}

impl TSConverter {
    pub fn new() -> Self {
        Self {
            template: include_str!("../templates/template.ts"),
        }
    }

    pub fn convert_to_src(&mut self, samples: &Vec<(ParamType, Vec<Token>)>) -> String {
        let custom_types = String::new();
        let mut testcases = String::new();

        for sample in samples {
            let (param_type, tokens) = sample;

            for token in tokens {
                // Generate sway code
                let testcase = self.convert_testcase(&token, &param_type);
                testcases.push_str(&testcase);
                testcases.push_str("\n");
            }
        }

        debug!("TS custom types: {}", custom_types);

        self.template
            .replace(CUSTOM_TYPES, &custom_types)
            .replace(TESTCASES, &testcases)
    }

    fn convert_testcase(&mut self, token: &Token, param_type: &ParamType) -> String {
        // let type_declaration = self.convert_to_declaration(param_type);

        // info!("TS Type declaration: {}", type_declaration);
        // NOTE: we don't use type_str because it's very hard to encode it for the enum type. Sway enums are represented a struct in typescript.
        // However, their interface changes. For example if you one wants to encode a value MyEnum {A: uint, B: bool} they create either an instance
        // like the following {A: 1} or {B: true}. Therefore the interface of the struct always changes.
        let _type_str = self.convert_type(param_type);
        let value_str = self.convert_value(token, param_type);
        let coder_instance = self.convert_to_coder_instance(param_type);
        // Extract struct informations from paramType

        format!(
            "
{{
    const v : any = {value_str};
    const coder = {coder_instance};
    const encoded = coder.encode(v);

    console.log(`Encoding[${{Array.from(encoded).join(\",\")}}]`);

    const [decodedValue, decodedLength] = coder.decode(encoded, 0);
    console.log(`Decoding[${{isEqual(v, decodedValue)}}]`);
}}
        "
        )
    }

    // NOTE the type assignment is a little arbitrary. Inspired from here
    // https://github.com/FuelLabs/fuels-ts/blob/master/packages/abi-coder/src/encoding/coders/
    fn convert_type(&mut self, param_type: &ParamType) -> String {
        match param_type {
            ParamType::Bool => "boolean".to_string(),
            ParamType::Unit | ParamType::U8 | ParamType::U16 | ParamType::U32 => {
                "number".to_string()
            }
            ParamType::U64 | ParamType::U128 | ParamType::U256 => "BNInput".to_string(),

            ParamType::StringSlice
            | ParamType::StringArray(_)
            | ParamType::String
            | ParamType::B256 => "string".to_string(),

            ParamType::Vector(param_type) => {
                let string_element_type = self.convert_type(param_type);
                format!("Array<{}>", string_element_type)
            }
            ParamType::Bytes | ParamType::RawSlice => "Array<number>".to_string(),
            ParamType::Tuple(types) => {
                let values: Vec<String> = types.iter().map(|p| self.convert_type(p)).collect();
                format!("[{}]", values.join(", "))
            }
            ParamType::Array(element_type, _size) => {
                let string_element_type = self.convert_type(element_type);
                format!("Array<{}>", string_element_type)
            }

            ParamType::Enum { name, .. } | ParamType::Struct { name, .. } => name.clone(),
        }
    }

    fn convert_value(&mut self, token: &Token, param_type: &ParamType) -> String {
        match token {
            // NOTE this is a hack to encode void variants
            Token::Unit => "[]".to_string(),
            Token::Bool(val) => val.to_string(),
            Token::U8(val) => val.to_string(),
            Token::U16(val) => val.to_string(),
            Token::U32(val) => val.to_string(),
            Token::U64(val) => format!("bn(\"{}\")", val.to_string()),
            Token::U128(val) => format!("bn(\"{}\")", val.to_string()),
            Token::U256(val) => format!("bn(\"{}\")", val.to_string()),
            Token::String(val) => format!("'{}'", val.to_string()),
            Token::B256(val) => format!("'0x{}'", hex::encode(val)),
            Token::RawSlice(val) | Token::Bytes(val) => {
                format!("{:?}", val) // NOTE Maybe not good practice to use debug
            }

            Token::StringSlice(val) | Token::StringArray(val) => {
                format!("'{}'", val.get_encodable_str().unwrap().to_string(),)
            }
            Token::Tuple(tokens) => {
                let ParamType::Tuple(types) = param_type else {
                    panic!("Tuple token without tuple param type")
                };
                let zip = tokens.iter().zip(types.iter());
                let values: Vec<String> = zip.map(|(t, p)| self.convert_value(t, p)).collect();

                format!("[{}]", values.join(", "))
            }
            Token::Struct(tokens) => {
                let ParamType::Struct {
                    name: _,
                    fields,
                    generics: _,
                } = param_type
                else {
                    panic!("Struct token without struct param type")
                };
                let mut code = format!("{{");
                for (i, token) in tokens.iter().enumerate() {
                    let field_value = self.convert_value(token, &fields[i].1);
                    let field_name = &fields[i].0;
                    code.push_str(&format!("{}: {},", field_name, field_value));
                }
                code.push_str("}");

                code
            }
            Token::Array(tokens) => {
                let ParamType::Array(element_type, _size) = param_type else {
                    panic!("Array token without array param type")
                };
                let values: Vec<String> = tokens
                    .iter()
                    .map(|t| self.convert_value(t, element_type))
                    .collect();
                format!("[{}]", values.join(", "))
            }
            Token::Vector(tokens) => {
                let ParamType::Vector(element_type) = param_type else {
                    panic!("Vector token without vector param type")
                };
                let values: Vec<String> = tokens
                    .iter()
                    .map(|t| self.convert_value(t, element_type))
                    .collect();
                format!("[{}]", values.join(", "))
            }

            Token::Enum(enum_selector) => {
                let (variant_index, token, enum_variants) = enum_selector.as_ref();
                let (variant_name, variant_param_type) =
                    enum_variants.select_variant(*variant_index).unwrap();
                let ParamType::Enum { .. } = param_type else {
                    unreachable!()
                };
                // NOTE This is a hack to handle void variants. They are currently encoded as a ArrayCoder with 0 size
                if matches!(token, Token::Unit) {
                    format!("{{{variant_name}: []}}")
                } else {
                    let token_str = self.convert_value(token, variant_param_type);
                    format!("{{ {variant_name}: {token_str} }}")
                }
            }
        }
    }

    fn convert_to_declaration(&mut self, param_type: &ParamType) -> String {
        let mut prefix_declarations: Vec<String> = Vec::new();
        match param_type {
            ParamType::Tuple(element_types) => {
                let _code = format!("type Tuple = [");
                for element_type in element_types {
                    let element_declaration = self.convert_to_declaration(element_type);
                    prefix_declarations.push(element_declaration);
                }
                prefix_declarations.retain(|x| !x.is_empty());
                prefix_declarations.join("\n")
            }

            ParamType::Array(element_type, _size) => self.convert_to_declaration(&element_type),

            ParamType::Vector(element_type) => self.convert_to_declaration(&element_type),

            ParamType::Struct { name, fields, .. } => {
                let mut code = format!("interface {} {{\n", name);
                for (field_name, field_type) in fields {
                    let field_declaration = self.convert_to_declaration(field_type);
                    prefix_declarations.push(field_declaration);
                    code.push_str(&format!(
                        "{} : {},\n",
                        field_name,
                        self.convert_type(field_type)
                    ));
                }
                code.push_str("}\n");
                prefix_declarations.push(code);

                prefix_declarations.join("\n");
                prefix_declarations.join("\n")
            }

            ParamType::Enum { .. } => "".to_string(),

            _ => String::new(),
        }
    }

    fn convert_to_coder_class(&mut self, param_type: &ParamType) -> String {
        match param_type {
            ParamType::Unit => panic!("No decoder for Unit type"),
            ParamType::Bool => "BooleanCoder".to_string(),
            ParamType::U8 => "NumberCoder".to_string(),
            ParamType::U16 => "NumberCoder".to_string(),
            ParamType::U32 => "NumberCoder".to_string(),
            ParamType::U64 => "BigNumberCoder".to_string(),
            ParamType::U128 => "BigNumberCoder".to_string(),
            ParamType::U256 => "BigNumberCoder".to_string(),
            ParamType::B256 => "B256Coder".to_string(),
            ParamType::Bytes => "ByteCoder".to_string(),
            ParamType::String => "StdStringCoder".to_string(),
            ParamType::RawSlice => "RawSliceCoder".to_string(),
            ParamType::StringArray(_) => "StringCoder".to_string(),
            ParamType::StringSlice => "StrSliceCoder".to_string(),
            ParamType::Tuple(types) => {
                let sub_classes = types
                    .iter()
                    .map(|t| self.convert_to_coder_class(t))
                    .collect::<Vec<String>>()
                    .join(",");
                format!("TupleCoder<[{sub_classes}]>")
            }
            ParamType::Array(param_type, _size) => {
                format!("ArrayCoder<{}>", self.convert_to_coder_class(param_type))
            }
            ParamType::Vector(param_type) => {
                format!("VecCoder<{}>", self.convert_to_coder_class(param_type))
            }
            ParamType::Struct { .. } => "StructCoder<any>".to_string(), // NOTE We could improve this to avoid using TS type inference
            ParamType::Enum { .. } => "EnumCoder<any>".to_string(),
        }
    }

    fn convert_to_coder_instance(&mut self, param_type: &ParamType) -> String {
        match param_type {
            ParamType::Unit => "new TupleCoder([])".to_string(),
            ParamType::Bool => "new BooleanCoder()".to_string(),
            ParamType::U8 => "new NumberCoder('u8')".to_string(),
            ParamType::U16 => "new NumberCoder('u16')".to_string(),
            ParamType::U32 => "new NumberCoder('u32')".to_string(),
            ParamType::U64 => "new BigNumberCoder('u64')".to_string(),
            ParamType::U128 => "new BigNumberCoder('u128')".to_string(),
            ParamType::U256 => "new BigNumberCoder('u256')".to_string(),
            ParamType::B256 => "new B256Coder()".to_string(),
            ParamType::Bytes => "new ByteCoder()".to_string(),
            ParamType::String => "new StdStringCoder()".to_string(),
            ParamType::RawSlice => "new RawSliceCoder()".to_string(),
            ParamType::StringArray(size) => format!("new StringCoder({size})"),
            ParamType::StringSlice => "new StrSliceCoder()".to_string(),
            ParamType::Tuple(types) => {
                let sub_classes = types
                    .iter()
                    .map(|t| self.convert_to_coder_class(t))
                    .collect::<Vec<String>>()
                    .join(",");
                let sub_instances = types
                    .iter()
                    .map(|t| self.convert_to_coder_instance(t))
                    .collect::<Vec<String>>()
                    .join(",");
                // Remove quotes from sub_classes
                format!("new TupleCoder<[{sub_classes}]>([{sub_instances}])")
            }
            ParamType::Array(inner_type, size) => {
                let class = self.convert_to_coder_class(param_type);
                let instance = self.convert_to_coder_instance(inner_type);
                format!("new {class}({instance}, {size})")
            }

            ParamType::Vector(inner_type) => {
                let class = self.convert_to_coder_class(param_type);
                let instance = self.convert_to_coder_instance(inner_type);
                format!("new {class}({instance})")
            }
            ParamType::Struct { name, fields, .. } => {
                let _class = self.convert_to_coder_class(param_type);
                let mut coder = format!("new StructCoder('{name}', {{");
                let mut fields_vec: Vec<String> = Vec::new();
                for (field_name, field_type) in fields {
                    let instance = self.convert_to_coder_instance(field_type);
                    fields_vec.push(format!("{field_name}: {instance}"));
                }
                coder.push_str(&fields_vec.join(","));
                coder.push_str("})");
                coder
            }
            ParamType::Enum {
                name,
                enum_variants,
                ..
            } => {
                let _class = self.convert_to_coder_class(param_type);
                let mut coder = format!("new EnumCoder('{name}', {{");
                let mut fields_vec: Vec<String> = Vec::new();
                for (variant_name, variant_type) in enum_variants.variants() {
                    let instance = self.convert_to_coder_instance(variant_type);
                    fields_vec.push(format!("{variant_name}: {instance}"));
                }

                coder.push_str(&fields_vec.join(","));
                coder.push_str("})");
                coder
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use fuels::types::{param_types::EnumVariants, StaticStringToken, U256};
    use tracing::info;

    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;
    type P = ParamType;
    type T = Token;

    #[test]
    fn test_array() {
        let param_type = P::Array(Box::new(P::U64), 2);
        let token: Token = Token::Array(vec![Token::U64(1), Token::U64(2)]);
        let mut converter = TSConverter::new();
        let type_str = converter.convert_type(&param_type);
        let value_str = converter.convert_value(&token, &param_type);
        let v_src = format!("const v: any = {value_str};");
        // dbg!(&v_src);
        assert_eq!(v_src, "const v: any = [bn(\"1\"), bn(\"2\")];");
        let coder = converter.convert_to_coder_instance(&param_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(
            coder_src,
            "const coder = new ArrayCoder<BigNumberCoder>(new BigNumberCoder('u64'), 2);"
        );
    }

    #[test]
    fn test_b256() {
        let param_type = P::B256;
        let token: Token = Token::B256([
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1,
        ]);
        let mut converter = TSConverter::new();
        let _src = converter.convert_testcase(&token, &param_type);
        let type_str = converter.convert_type(&param_type);
        let value_str = converter.convert_value(&token, &param_type);
        let v_src = format!("const v: {type_str} = {value_str};");
        // dbg!(&v_src);
        assert_eq!(
            v_src,
            "const v: string = '0x0101010101010101010101010101010101010101010101010101010101010101';"
        );
        let coder = converter.convert_to_coder_instance(&param_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(coder_src, "const coder = new B256Coder();");
    }

    #[test]
    fn test_u128() {
        let param_type = P::U128;
        let token: Token = Token::U128(1);
        let mut converter = TSConverter::new();
        let type_str = converter.convert_type(&param_type);
        let value_str = converter.convert_value(&token, &param_type);
        let v_src = format!("const v: any = {value_str};");
        // dbg!(&v_src);
        assert_eq!(v_src, "const v: any = bn(\"1\");");
        let coder = converter.convert_to_coder_instance(&param_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(coder_src, "const coder = new BigNumberCoder('u128');");
    }

    #[test]
    fn test_u256() {
        let param_type = P::U256;
        let token: Token = Token::U256(U256::from(1));
        let mut converter = TSConverter::new();
        let _src = converter.convert_testcase(&token, &param_type);

        let type_str = converter.convert_type(&param_type);
        let value_str = converter.convert_value(&token, &param_type);
        let v_src = format!("const v: any = {value_str};");
        // dbg!(&v_src);
        assert_eq!(v_src, "const v: any = bn(\"1\");");
        let coder = converter.convert_to_coder_instance(&param_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(coder_src, "const coder = new BigNumberCoder('u256');");
    }

    #[test]
    fn test_boolean() {
        let param_type = P::Bool;

        // Test true value
        let token: T = Token::Bool(true);
        let mut converter = TSConverter::new();
        let _src = converter.convert_testcase(&token, &param_type);

        let type_str = converter.convert_type(&param_type);
        let value_str = converter.convert_value(&token, &param_type);
        let v_src = format!("const v: any = {value_str};");
        // dbg!(&v_src);
        assert_eq!(v_src, "const v: any = true;");
        let coder = converter.convert_to_coder_instance(&param_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(coder_src, "const coder = new BooleanCoder();");
    }

    #[test]
    fn test_byte() {
        let param_type = P::Bytes;

        // Sample byte array
        let token: T = Token::Bytes(vec![1, 2, 3]);
        let mut converter = TSConverter::new();
        let src = converter.convert_testcase(&token, &param_type);
        info!("{}", src);
        let type_str = converter.convert_type(&param_type);
        let value_str = converter.convert_value(&token, &param_type);
        let v_src = format!("const v: {type_str} = {value_str};");
        // dbg!(&v_src);
        assert_eq!(v_src, "const v: Array<number> = [1, 2, 3];");
        let coder = converter.convert_to_coder_instance(&param_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(coder_src, "const coder = new ByteCoder();");
    }

    #[test]
    fn test_u64() {
        let param_type = P::U64;
        let token: Token = Token::U64(1);
        let mut converter = TSConverter::new();
        let type_str = converter.convert_type(&param_type);
        let value_str = converter.convert_value(&token, &param_type);
        let v_src = format!("const v: any = {value_str};");
        // dbg!(&v_src);
        assert_eq!(v_src, "const v: any = bn(\"1\");");
        let coder = converter.convert_to_coder_instance(&param_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(coder_src, "const coder = new BigNumberCoder('u64');");
    }
    #[test]
    fn test_raw_slice() {
        let param_type = P::RawSlice;
        let token: T = Token::RawSlice(vec![1, 2, 3]);
        let mut converter = TSConverter::new();
        let type_str = converter.convert_type(&param_type);
        let value_str = converter.convert_value(&token, &param_type);
        let v_src = format!("const v: {type_str} = {value_str};");
        assert_eq!(v_src, "const v: Array<number> = [1, 2, 3];");
        // dbg!(&v_src);
        let coder = converter.convert_to_coder_instance(&param_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(coder_src, "const coder = new RawSliceCoder();");
    }

    #[test]
    fn test_string_array() {
        let param_type = P::StringArray(5);

        // Sample byte array
        let token: T = T::StringArray(StaticStringToken::new("hello".to_string(), Some(5)));
        let mut converter = TSConverter::new();
        let type_str = converter.convert_type(&param_type);
        let value_str = converter.convert_value(&token, &param_type);
        let v_src = format!("const v: {type_str} = {value_str};");
        assert_eq!(v_src, "const v: string = 'hello';");
        // dbg!(&v_src);
        let coder = converter.convert_to_coder_instance(&param_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(coder_src, "const coder = new StringCoder(5);");
    }

    #[test]
    fn test_str_slice() {
        let param_type = P::StringSlice;

        // Sample byte array
        let token: T = T::StringSlice(StaticStringToken::new("hello".to_string(), Some(5)));
        let mut converter = TSConverter::new();
        let type_str = converter.convert_type(&param_type);
        let value_str = converter.convert_value(&token, &param_type);
        let v_src = format!("const v: {type_str} = {value_str};");
        assert_eq!(v_src, "const v: string = 'hello';");
        // dbg!(&v_src);
        let coder = converter.convert_to_coder_instance(&param_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(coder_src, "const coder = new StrSliceCoder();");
    }

    #[test]
    fn test_string() {
        let param_type = P::String;

        // Sample byte array
        let token: T = T::String("hello".to_string());
        let mut converter = TSConverter::new();
        let type_str = converter.convert_type(&param_type);
        let value_str = converter.convert_value(&token, &param_type);
        let v_src = format!("const v: {type_str} = {value_str};");
        assert_eq!(v_src, "const v: string = 'hello';");
        // dbg!(&v_src);
        let coder = converter.convert_to_coder_instance(&param_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(coder_src, "const coder = new StdStringCoder();");
    }

    #[test]
    fn test_struct() {
        let u64_type = P::U64;
        let inner_type = P::Struct {
            name: "inner".to_string(),
            fields: vec![("int".to_string(), u64_type)],
            generics: vec![],
        };
        let outer_type = P::Struct {
            name: "outer".to_string(),
            fields: vec![("inner".to_string(), inner_type)],
            generics: vec![],
        };

        let u64_value = T::U64(42);
        let inner_value = T::Struct(vec![u64_value]);

        let outer_value: T = T::Struct(vec![inner_value]);
        let mut converter = TSConverter::new();
        let type_str = converter.convert_type(&outer_type);
        let value_str = converter.convert_value(&outer_value, &outer_type);
        let v_src = format!("const v: any = {value_str};");
        assert_eq!(v_src, "const v: any = {inner: {int: bn(\"42\"),},};");
        // dbg!(&v_src);
        let coder = converter.convert_to_coder_instance(&outer_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(coder_src, "const coder = new StructCoder('outer', {inner: new StructCoder('inner', {int: new BigNumberCoder('u64')})});");
    }
    #[test]
    fn test_tuple() {
        let tuple_type = P::Tuple(vec![P::U64, P::String]);
        let tuple_value = T::Tuple(vec![T::U64(42), T::String("hello".to_string())]);
        let mut converter = TSConverter::new();
        let type_str = converter.convert_type(&tuple_type);
        let value_str = converter.convert_value(&tuple_value, &tuple_type);
        let v_src = format!("const v: any = {value_str};");
        assert_eq!(v_src, "const v: any = [bn(\"42\"), 'hello'];");
        // dbg!(&v_src);
        let coder = converter.convert_to_coder_instance(&tuple_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(coder_src, "const coder = new TupleCoder<[BigNumberCoder,StdStringCoder]>([new BigNumberCoder('u64'),new StdStringCoder()]);");
    }
    #[test]
    fn test_vec() {
        let param_type = P::Vector(Box::new(P::U64));
        let token: Token = Token::Vector(vec![Token::U64(1), Token::U64(2)]);
        let mut converter = TSConverter::new();
        let type_str = converter.convert_type(&param_type);
        let value_str = converter.convert_value(&token, &param_type);
        let v_src = format!("const v: any = {value_str};");
        assert_eq!(v_src, "const v: any = [bn(\"1\"), bn(\"2\")];");
        // dbg!(&v_src);
        let coder = converter.convert_to_coder_instance(&param_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        assert_eq!(
            coder_src,
            "const coder = new VecCoder<BigNumberCoder>(new BigNumberCoder('u64'));"
        );
    }

    #[test]
    fn test_enum_vector() {
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

        let mut converter = TSConverter::new();
        let type_str = converter.convert_type(&enum_type);
        let value_str = converter.convert_value(&enum_token, &enum_type);
        let v_src = format!("const v = {value_str};");

        info!("{}", &v_src);
        assert_eq!(v_src, "const v = { aVec: [bn(\"1\"), bn(\"2\")] };");
        // dbg!(&v_src);
        let coder = converter.convert_to_coder_instance(&enum_type);
        let coder_src = format!("const coder = {coder};");
        // dbg!(&coder_src);
        info!("{}", &coder_src);
        // assert_eq!(
        //     coder_src,
        //     "const coder = new MyEnum(new BigNumberCoder('u64'));"
        // );
    }

    #[test]
    fn test_enum_unit() {
        let vector_type = P::Vector(Box::new(P::U64));
        let _vector_token: Token = Token::Unit;
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

        let mut converter = TSConverter::new();
        let type_str = converter.convert_type(&enum_type);
        let value_str = converter.convert_value(&enum_token, &enum_type);
        let v_src = format!("const v: any = {value_str};");
        assert_eq!(v_src, "const v: any = {aVariant: []};");
    }

    #[test]
    fn test_convert_to_src() {
        let param_type = P::Vector(Box::new(P::U64));
        let token: Token = Token::Vector(vec![Token::U64(1), Token::U64(2)]);
        let mut converter = TSConverter::new();
        let samples = vec![(param_type, vec![token])];
        let src = converter.convert_to_src(&samples);
        info!("{}", src);
    }
}
