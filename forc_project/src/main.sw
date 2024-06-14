script;

use std::vec::Vec;
use std::address::Address;
use core::codec::*;
use core::codec::Buffer;
use std::bytes::Bytes;
use std::string::String;

struct Struct2 {
	field1 : u16,
	field2 : u16,
	field3 : Bytes,
	field4 : str,
	field5 : raw_slice,
}

enum Enum0 {
	Variant1 : Struct2,
	Variant2 : str,
}

impl Enum0 {
    fn get_Variant1(self) -> Struct2 {
        match self {
            Enum0::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> str {
        match self {
            Enum0::Variant2(v) => v,
            _ => revert(0),
        }
    }
}

fn main() -> () {

    

    let v: (u16, Enum0) = (19007, Enum0::Variant2("e"));
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<(u16, Enum0)>(encoded);
    log(v.0 == decoded.0);
	log(v.1.get_Variant2() == decoded.1.get_Variant2());

  
return
}
