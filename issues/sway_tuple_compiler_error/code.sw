script;

use std::vec::Vec;
use std::address::Address;
use core::codec::*;
use core::codec::Buffer;
use std::bytes::Bytes;
use std::string::String;

struct Struct6 {
	field1 : u64,
	field2 : bool,
	field3 : (Vec<u64>, (Vec<b256>), String, str[4]),
	field4 : u64,
	field5 : bool,
}

enum Enum5 {
	Variant1 : Struct6,
	Variant2 : [u8; 5],
}

impl Enum5 {
    fn get_Variant1(self) -> Struct6 {
        match self {
            Enum5::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> [u8; 5] {
        match self {
            Enum5::Variant2(v) => v,
            _ => revert(0),
        }
    }
}enum Enum7 {
	Variant1 : str[2],
	Variant2 : u64,
	Variant3 : Vec<(Vec<str[2]>, b256, u64, Vec<str[5]>)>,
	Variant4 : str[3],
}

impl Enum7 {
    fn get_Variant1(self) -> str[2] {
        match self {
            Enum7::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> u64 {
        match self {
            Enum7::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Vec<(Vec<str[2]>, b256, u64, Vec<str[5]>)> {
        match self {
            Enum7::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> str[3] {
        match self {
            Enum7::Variant4(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct8 {
	field1 : bool,
	field2 : [str; 2],
	field3 : b256,
	field4 : (String, str, u256),
}

struct Struct9 {
	field1 : u32,
	field2 : u16,
	field3 : u16,
}

enum Enum8 {
	Variant1 : Struct9,
}

impl Enum8 {
    fn get_Variant1(self) -> Struct9 {
        match self {
            Enum8::Variant1(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct7 {
	field1 : u16,
	field2 : (Vec<u256>, Struct8, raw_slice, Enum8, u64),
	field3 : u16,
	field4 : bool,
}

enum Enum6 {
	Variant1 : u16,
	Variant2 : Enum7,
	Variant3 : Struct7,
	Variant4 : Vec<u64>,
	Variant5 : [b256; 5],
}

impl Enum6 {
    fn get_Variant1(self) -> u16 {
        match self {
            Enum6::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> Enum7 {
        match self {
            Enum6::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Struct7 {
        match self {
            Enum6::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> Vec<u64> {
        match self {
            Enum6::Variant4(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant5(self) -> [b256; 5] {
        match self {
            Enum6::Variant5(v) => v,
            _ => revert(0),
        }
    }
}

fn main() -> () {

    

    let v: Enum5 = Enum5::Variant2([138u8, 67u8, 44u8, 32u8, 84u8]);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum5>(encoded);
    log(v.get_Variant2()[0] == decoded.get_Variant2()[0]);
	log(v.get_Variant2()[1] == decoded.get_Variant2()[1]);
	log(v.get_Variant2()[2] == decoded.get_Variant2()[2]);
	log(v.get_Variant2()[3] == decoded.get_Variant2()[3]);
	log(v.get_Variant2()[4] == decoded.get_Variant2()[4]);
    

    let v: (str[2]) = (__to_str_array("*"));
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<(str[2])>(encoded);
    log(from_str_array(v.0) == from_str_array(decoded.0));
	let mut bytes0 = Bytes::new();
	bytes0.push(81u8);
	bytes0.push(160u8);
	bytes0.push(240u8);
	bytes0.push(79u8);
    

    let v: Bytes = bytes0;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Bytes>(encoded);
    log(v == decoded);
    

    let v: u64 = 2078104745928214428;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u64>(encoded);
    log(v == decoded);
	let mut vector0 : Vec<u256> = Vec::new();
	vector0.push(0x13db015804ba42412e20f8d4847fe8d9d1659b6a778f0da5155d6a48bd7edc5bu256);
	vector0.push(0xda32b8914c8d0038a3942a08e8c41c0500c2f10acab3d28b87be023a3b286e29u256);
	vector0.push(0x7474a230d9b77ee744a70a8f5f11f5d735d616f4f74310f71fd0d29880056544u256);
	vector0.push(0xc676d894e66881e9e69de479921dd96c8351111419d03692804eb112b0b820e2u256);
	vector0.push(0x635b32830439fb5a7e54013a9ca00c2d07a0ba31c1ff12da4780e34e9549e8b3u256);

	let mut bytes1 = Bytes::new();
	bytes1.push(85u8);
	bytes1.push(114u8);
	bytes1.push(148u8);

	let raw_slice0 = bytes1.as_raw_slice();
    

    let v: Enum6 = Enum6::Variant3(Struct7 {field1 : 21296,field2 : (vector0, Struct8 {field1 : false,field2 : ["&-", "DR"],field3 : 0xfa1bae075ba0415f69e558db69e83f106ddbc015ebfdbeaf78ee3607aae708d7,field4 : (String::from_ascii_str("b"), ",X", 0xfe813165975c04e4269547409e3c11e18f44d1639a473c21c03220a398f6f33bu256),}, raw_slice0, Enum8::Variant1(Struct9 {field1 : 962209076,field2 : 52471,field3 : 10703,}), 13870602556519144540),field3 : 1050,field4 : false,});
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum6>(encoded);
    log(v.get_Variant3().field1 == decoded.get_Variant3().field1);
	log(v.get_Variant3().field2.0.get(0).unwrap() == decoded.get_Variant3().field2.0.get(0).unwrap());
	log(v.get_Variant3().field2.0.get(1).unwrap() == decoded.get_Variant3().field2.0.get(1).unwrap());
	log(v.get_Variant3().field2.0.get(2).unwrap() == decoded.get_Variant3().field2.0.get(2).unwrap());
	log(v.get_Variant3().field2.0.get(3).unwrap() == decoded.get_Variant3().field2.0.get(3).unwrap());
	log(v.get_Variant3().field2.0.get(4).unwrap() == decoded.get_Variant3().field2.0.get(4).unwrap());
	log(v.get_Variant3().field2.1.field1 == decoded.get_Variant3().field2.1.field1);
	log(v.get_Variant3().field2.1.field2[0] == decoded.get_Variant3().field2.1.field2[0]);
	log(v.get_Variant3().field2.1.field2[1] == decoded.get_Variant3().field2.1.field2[1]);
	log(v.get_Variant3().field2.1.field3 == decoded.get_Variant3().field2.1.field3);
	log(v.get_Variant3().field2.1.field4.0 == decoded.get_Variant3().field2.1.field4.0);
	log(v.get_Variant3().field2.1.field4.1 == decoded.get_Variant3().field2.1.field4.1);
	log(v.get_Variant3().field2.1.field4.2 == decoded.get_Variant3().field2.1.field4.2);
	log(Bytes::from(v.get_Variant3().field2.2) == Bytes::from(decoded.get_Variant3().field2.2));
	log(v.get_Variant3().field2.3.get_Variant1().field1 == decoded.get_Variant3().field2.3.get_Variant1().field1);
	log(v.get_Variant3().field2.3.get_Variant1().field2 == decoded.get_Variant3().field2.3.get_Variant1().field2);
	log(v.get_Variant3().field2.3.get_Variant1().field3 == decoded.get_Variant3().field2.3.get_Variant1().field3);
	log(v.get_Variant3().field2.4 == decoded.get_Variant3().field2.4);
	log(v.get_Variant3().field3 == decoded.get_Variant3().field3);
	log(v.get_Variant3().field4 == decoded.get_Variant3().field4);

  
return
}
