script;

use std::vec::Vec;
use std::address::Address;
use core::codec::*;
use core::codec::Buffer;
use std::bytes::Bytes;
use std::string::String;

struct Struct1 {
	field1 : u16,
	field2 : raw_slice,
	field3 : u16,
}

struct Struct0 {
	field1 : u32,
	field2 : Struct1,
	field3 : Bytes,
}
struct Struct2 {
	field1 : u16,
}
enum Enum1 {
	Variant1 : str,
}

impl Enum1 {
    fn get_Variant1(self) -> str {
        match self {
            Enum1::Variant1(v) => v,
            _ => revert(0),
        }
    }
}
enum Enum0 {
	Variant1 : str[4],
	Variant2 : Enum1,
}

impl Enum0 {
    fn get_Variant1(self) -> str[4] {
        match self {
            Enum0::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> Enum1 {
        match self {
            Enum0::Variant2(v) => v,
            _ => revert(0),
        }
    }
}struct Struct4 {
	field1 : Bytes,
	field2 : u16,
	field3 : Bytes,
	field4 : u16,
	field5 : b256,
}

enum Enum2 {
	Variant1 : (u32, u32),
	Variant2 : (str, str[5], u16),
	Variant3 : Struct4,
}

impl Enum2 {
    fn get_Variant1(self) -> (u32, u32) {
        match self {
            Enum2::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> (str, str[5], u16) {
        match self {
            Enum2::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Struct4 {
        match self {
            Enum2::Variant3(v) => v,
            _ => revert(0),
        }
    }
}
enum Enum3 {
	Variant1 : String,
	Variant2 : str,
	Variant3 : str[3],
}

impl Enum3 {
    fn get_Variant1(self) -> String {
        match self {
            Enum3::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> str {
        match self {
            Enum3::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> str[3] {
        match self {
            Enum3::Variant3(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct5 {
	field1 : Vec<u16>,
	field2 : Enum3,
	field3 : u8,
	field4 : Vec<str>,
}

struct Struct3 {
	field1 : str,
	field2 : Enum2,
	field3 : Struct5,
	field4 : [u32; 1],
}
struct Struct6 {
	field1 : Bytes,
}
enum Enum5 {
	Variant1 : [u8; 1],
	Variant2 : str,
}

impl Enum5 {
    fn get_Variant1(self) -> [u8; 1] {
        match self {
            Enum5::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> str {
        match self {
            Enum5::Variant2(v) => v,
            _ => revert(0),
        }
    }
}
enum Enum6 {
	Variant1 : Bytes,
	Variant2 : String,
	Variant3 : str[1],
	Variant4 : raw_slice,
	Variant5 : u256,
}

impl Enum6 {
    fn get_Variant1(self) -> Bytes {
        match self {
            Enum6::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> String {
        match self {
            Enum6::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> str[1] {
        match self {
            Enum6::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> raw_slice {
        match self {
            Enum6::Variant4(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant5(self) -> u256 {
        match self {
            Enum6::Variant5(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct7 {
	field1 : raw_slice,
	field2 : u64,
	field3 : bool,
	field4 : u32,
	field5 : Enum6,
}

enum Enum4 {
	Variant1 : Enum5,
	Variant2 : bool,
	Variant3 : Struct7,
	Variant4 : u64,
}

impl Enum4 {
    fn get_Variant1(self) -> Enum5 {
        match self {
            Enum4::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> bool {
        match self {
            Enum4::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Struct7 {
        match self {
            Enum4::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> u64 {
        match self {
            Enum4::Variant4(v) => v,
            _ => revert(0),
        }
    }
}struct Struct8 {
	field1 : Vec<str[4]>,
}
struct Struct9 {
	field1 : raw_slice,
	field2 : u256,
	field3 : (Vec<str>, u256, bool, str),
	field4 : u32,
}
enum Enum9 {
	Variant1 : str,
	Variant2 : (),
}

impl Enum9 {
    fn get_Variant1(self) -> str {
        match self {
            Enum9::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> bool {
        match self {
            Enum9::Variant2(v) => true,
            _ => revert(0),
        }
    }
}
enum Enum8 {
	Variant1 : str[2],
	Variant2 : Enum9,
	Variant3 : Vec<u64>,
	Variant4 : raw_slice,
}

impl Enum8 {
    fn get_Variant1(self) -> str[2] {
        match self {
            Enum8::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> Enum9 {
        match self {
            Enum8::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Vec<u64> {
        match self {
            Enum8::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> raw_slice {
        match self {
            Enum8::Variant4(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct10 {
	field1 : str[4],
	field2 : str[2],
}

enum Enum10 {
	Variant1 : u32,
	Variant2 : (u32, u8, bool),
	Variant3 : Struct10,
}

impl Enum10 {
    fn get_Variant1(self) -> u32 {
        match self {
            Enum10::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> (u32, u8, bool) {
        match self {
            Enum10::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Struct10 {
        match self {
            Enum10::Variant3(v) => v,
            _ => revert(0),
        }
    }
}
enum Enum7 {
	Variant1 : Enum8,
	Variant2 : Enum10,
	Variant3 : Vec<b256>,
}

impl Enum7 {
    fn get_Variant1(self) -> Enum8 {
        match self {
            Enum7::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> Enum10 {
        match self {
            Enum7::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Vec<b256> {
        match self {
            Enum7::Variant3(v) => v,
            _ => revert(0),
        }
    }
}struct Struct12 {
	field1 : u64,
	field2 : String,
}

enum Enum11 {
	Variant1 : String,
	Variant2 : str[2],
	Variant3 : raw_slice,
}

impl Enum11 {
    fn get_Variant1(self) -> String {
        match self {
            Enum11::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> str[2] {
        match self {
            Enum11::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> raw_slice {
        match self {
            Enum11::Variant3(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct11 {
	field1 : Struct12,
	field2 : (u256, Vec<u32>, [u64; 3], Enum11, [u8; 5]),
}
enum Enum12 {
	Variant1 : str,
	Variant2 : bool,
	Variant3 : (u32, u32, u8, u64),
	Variant4 : u32,
	Variant5 : str,
}

impl Enum12 {
    fn get_Variant1(self) -> str {
        match self {
            Enum12::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> bool {
        match self {
            Enum12::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> (u32, u32, u8, u64) {
        match self {
            Enum12::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> u32 {
        match self {
            Enum12::Variant4(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant5(self) -> str {
        match self {
            Enum12::Variant5(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct13 {
	field1 : Vec<str[1]>,
	field2 : u32,
	field3 : Bytes,
	field4 : u256,
	field5 : Enum12,
}
enum Enum13 {
	Variant1 : u16,
	Variant2 : String,
	Variant3 : u256,
	Variant4 : u64,
	Variant5 : String,
}

impl Enum13 {
    fn get_Variant1(self) -> u16 {
        match self {
            Enum13::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> String {
        match self {
            Enum13::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> u256 {
        match self {
            Enum13::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> u64 {
        match self {
            Enum13::Variant4(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant5(self) -> String {
        match self {
            Enum13::Variant5(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct14 {
	field1 : (Enum13, Vec<b256>, [u8; 4], Bytes),
	field2 : u32,
}
struct Struct15 {
	field1 : u256,
	field2 : bool,
}

enum Enum14 {
	Variant1 : (b256, Struct15, b256),
	Variant2 : Vec<Vec<str>>,
}

impl Enum14 {
    fn get_Variant1(self) -> (b256, Struct15, b256) {
        match self {
            Enum14::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> Vec<Vec<str>> {
        match self {
            Enum14::Variant2(v) => v,
            _ => revert(0),
        }
    }
}struct Struct16 {
	field1 : [str; 1],
	field2 : u256,
}

enum Enum15 {
	Variant1 : str[3],
	Variant2 : b256,
	Variant3 : Struct16,
}

impl Enum15 {
    fn get_Variant1(self) -> str[3] {
        match self {
            Enum15::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> b256 {
        match self {
            Enum15::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Struct16 {
        match self {
            Enum15::Variant3(v) => v,
            _ => revert(0),
        }
    }
}struct Struct18 {
	field1 : u64,
	field2 : Bytes,
}

enum Enum17 {
	Variant1 : u32,
	Variant2 : u32,
	Variant3 : b256,
	Variant4 : Bytes,
}

impl Enum17 {
    fn get_Variant1(self) -> u32 {
        match self {
            Enum17::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> u32 {
        match self {
            Enum17::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> b256 {
        match self {
            Enum17::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> Bytes {
        match self {
            Enum17::Variant4(v) => v,
            _ => revert(0),
        }
    }
}
enum Enum16 {
	Variant1 : Struct18,
	Variant2 : Enum17,
}

impl Enum16 {
    fn get_Variant1(self) -> Struct18 {
        match self {
            Enum16::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> Enum17 {
        match self {
            Enum16::Variant2(v) => v,
            _ => revert(0),
        }
    }
}
enum Enum18 {
	Variant1 : (u8, String, String, u8, raw_slice),
	Variant2 : u32,
	Variant3 : bool,
	Variant4 : (bool, bool, u16, raw_slice),
}

impl Enum18 {
    fn get_Variant1(self) -> (u8, String, String, u8, raw_slice) {
        match self {
            Enum18::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> u32 {
        match self {
            Enum18::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> bool {
        match self {
            Enum18::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> (bool, bool, u16, raw_slice) {
        match self {
            Enum18::Variant4(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct17 {
	field1 : raw_slice,
	field2 : Enum16,
	field3 : Enum18,
}
enum Enum20 {
	Variant1 : Bytes,
	Variant2 : String,
}

impl Enum20 {
    fn get_Variant1(self) -> Bytes {
        match self {
            Enum20::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> String {
        match self {
            Enum20::Variant2(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct20 {
	field1 : u8,
	field2 : u256,
	field3 : Bytes,
}

enum Enum19 {
	Variant1 : Enum20,
	Variant2 : (u64, u64, u8),
	Variant3 : raw_slice,
	Variant4 : Struct20,
}

impl Enum19 {
    fn get_Variant1(self) -> Enum20 {
        match self {
            Enum19::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> (u64, u64, u8) {
        match self {
            Enum19::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> raw_slice {
        match self {
            Enum19::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> Struct20 {
        match self {
            Enum19::Variant4(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct19 {
	field1 : Enum19,
	field2 : Vec<Vec<u16>>,
	field3 : u8,
	field4 : Vec<Bytes>,
	field5 : Vec<Bytes>,
}
struct Struct21 {
	field1 : (String, u8, Bytes, String),
	field2 : str[4],
}

enum Enum21 {
	Variant1 : Struct21,
}

impl Enum21 {
    fn get_Variant1(self) -> Struct21 {
        match self {
            Enum21::Variant1(v) => v,
            _ => revert(0),
        }
    }
}enum Enum22 {
	Variant1 : (),
	Variant2 : [Bytes; 2],
	Variant3 : Vec<Bytes>,
	Variant4 : u256,
}

impl Enum22 {
    fn get_Variant1(self) -> bool {
        match self {
            Enum22::Variant1(v) => true,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> [Bytes; 2] {
        match self {
            Enum22::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Vec<Bytes> {
        match self {
            Enum22::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> u256 {
        match self {
            Enum22::Variant4(v) => v,
            _ => revert(0),
        }
    }
}
enum Enum23 {
	Variant1 : u8,
	Variant2 : raw_slice,
	Variant3 : u8,
}

impl Enum23 {
    fn get_Variant1(self) -> u8 {
        match self {
            Enum23::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> raw_slice {
        match self {
            Enum23::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> u8 {
        match self {
            Enum23::Variant3(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct22 {
	field1 : u8,
	field2 : Enum23,
	field3 : u8,
	field4 : str[3],
}

struct Struct24 {
	field1 : Bytes,
}

struct Struct23 {
	field1 : Struct24,
	field2 : Vec<u16>,
	field3 : Vec<String>,
	field4 : [str; 5],
	field5 : (u8, u256, u8, str),
}
struct Struct25 {
	field1 : bool,
	field2 : Vec<String>,
}
struct Struct27 {
	field1 : u64,
	field2 : String,
	field3 : b256,
	field4 : u64,
	field5 : u8,
}

enum Enum24 {
	Variant1 : raw_slice,
	Variant2 : u32,
}

impl Enum24 {
    fn get_Variant1(self) -> raw_slice {
        match self {
            Enum24::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> u32 {
        match self {
            Enum24::Variant2(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct26 {
	field1 : Struct27,
	field2 : u8,
	field3 : Enum24,
}
struct Struct28 {
	field1 : b256,
}

enum Enum26 {
	Variant1 : String,
}

impl Enum26 {
    fn get_Variant1(self) -> String {
        match self {
            Enum26::Variant1(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct29 {
	field1 : Enum26,
	field2 : u8,
	field3 : [u32; 2],
	field4 : (u16, u256),
}

enum Enum25 {
	Variant1 : raw_slice,
	Variant2 : [Struct28; 5],
	Variant3 : Struct29,
	Variant4 : str,
}

impl Enum25 {
    fn get_Variant1(self) -> raw_slice {
        match self {
            Enum25::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> [Struct28; 5] {
        match self {
            Enum25::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Struct29 {
        match self {
            Enum25::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> str {
        match self {
            Enum25::Variant4(v) => v,
            _ => revert(0),
        }
    }
}enum Enum27 {
	Variant1 : bool,
	Variant2 : u32,
}

impl Enum27 {
    fn get_Variant1(self) -> bool {
        match self {
            Enum27::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> u32 {
        match self {
            Enum27::Variant2(v) => v,
            _ => revert(0),
        }
    }
}enum Enum29 {
	Variant1 : u256,
}

impl Enum29 {
    fn get_Variant1(self) -> u256 {
        match self {
            Enum29::Variant1(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct30 {
	field1 : u8,
	field2 : u8,
	field3 : raw_slice,
	field4 : u8,
	field5 : raw_slice,
}

enum Enum30 {
	Variant1 : String,
	Variant2 : u64,
	Variant3 : b256,
}

impl Enum30 {
    fn get_Variant1(self) -> String {
        match self {
            Enum30::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> u64 {
        match self {
            Enum30::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> b256 {
        match self {
            Enum30::Variant3(v) => v,
            _ => revert(0),
        }
    }
}
enum Enum28 {
	Variant1 : Enum29,
	Variant2 : u256,
	Variant3 : Struct30,
	Variant4 : Enum30,
	Variant5 : str,
}

impl Enum28 {
    fn get_Variant1(self) -> Enum29 {
        match self {
            Enum28::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> u256 {
        match self {
            Enum28::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Struct30 {
        match self {
            Enum28::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> Enum30 {
        match self {
            Enum28::Variant4(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant5(self) -> str {
        match self {
            Enum28::Variant5(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct31 {
	field1 : Bytes,
	field2 : str,
	field3 : bool,
	field4 : u16,
	field5 : u32,
}
enum Enum31 {
	Variant1 : b256,
}

impl Enum31 {
    fn get_Variant1(self) -> b256 {
        match self {
            Enum31::Variant1(v) => v,
            _ => revert(0),
        }
    }
}enum Enum32 {
	Variant1 : Vec<Bytes>,
	Variant2 : u256,
	Variant3 : u16,
}

impl Enum32 {
    fn get_Variant1(self) -> Vec<Bytes> {
        match self {
            Enum32::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> u256 {
        match self {
            Enum32::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> u16 {
        match self {
            Enum32::Variant3(v) => v,
            _ => revert(0),
        }
    }
}enum Enum33 {
	Variant1 : raw_slice,
	Variant2 : u32,
	Variant3 : raw_slice,
	Variant4 : [b256; 1],
}

impl Enum33 {
    fn get_Variant1(self) -> raw_slice {
        match self {
            Enum33::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> u32 {
        match self {
            Enum33::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> raw_slice {
        match self {
            Enum33::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> [b256; 1] {
        match self {
            Enum33::Variant4(v) => v,
            _ => revert(0),
        }
    }
}enum Enum34 {
	Variant1 : Vec<String>,
	Variant2 : String,
}

impl Enum34 {
    fn get_Variant1(self) -> Vec<String> {
        match self {
            Enum34::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> String {
        match self {
            Enum34::Variant2(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct32 {
	field1 : Vec<u32>,
	field2 : u256,
	field3 : Enum34,
	field4 : ((u256, str, str, b256, String), [String; 2]),
	field5 : raw_slice,
}
enum Enum36 {
	Variant1 : [u64; 5],
	Variant2 : Vec<u16>,
	Variant3 : b256,
	Variant4 : (u256, str, u256),
}

impl Enum36 {
    fn get_Variant1(self) -> [u64; 5] {
        match self {
            Enum36::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> Vec<u16> {
        match self {
            Enum36::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> b256 {
        match self {
            Enum36::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> (u256, str, u256) {
        match self {
            Enum36::Variant4(v) => v,
            _ => revert(0),
        }
    }
}
enum Enum35 {
	Variant1 : u256,
	Variant2 : u32,
	Variant3 : Enum36,
	Variant4 : (),
}

impl Enum35 {
    fn get_Variant1(self) -> u256 {
        match self {
            Enum35::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> u32 {
        match self {
            Enum35::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Enum36 {
        match self {
            Enum35::Variant3(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant4(self) -> bool {
        match self {
            Enum35::Variant4(v) => true,
            _ => revert(0),
        }
    }
}struct Struct33 {
	field1 : bool,
	field2 : String,
	field3 : u16,
	field4 : u16,
}
enum Enum38 {
	Variant1 : u256,
	Variant2 : u8,
}

impl Enum38 {
    fn get_Variant1(self) -> u256 {
        match self {
            Enum38::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> u8 {
        match self {
            Enum38::Variant2(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct34 {
	field1 : b256,
	field2 : Enum38,
	field3 : bool,
	field4 : u8,
	field5 : (u16, u8, bool),
}

enum Enum37 {
	Variant1 : Struct34,
}

impl Enum37 {
    fn get_Variant1(self) -> Struct34 {
        match self {
            Enum37::Variant1(v) => v,
            _ => revert(0),
        }
    }
}enum Enum39 {
	Variant1 : [Vec<u32>; 2],
	Variant2 : Vec<raw_slice>,
	Variant3 : Bytes,
}

impl Enum39 {
    fn get_Variant1(self) -> [Vec<u32>; 2] {
        match self {
            Enum39::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> Vec<raw_slice> {
        match self {
            Enum39::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Bytes {
        match self {
            Enum39::Variant3(v) => v,
            _ => revert(0),
        }
    }
}struct Struct37 {
	field1 : str,
	field2 : u256,
	field3 : str,
	field4 : u64,
}

struct Struct36 {
	field1 : u8,
	field2 : u256,
	field3 : u64,
	field4 : Struct37,
}

struct Struct35 {
	field1 : b256,
	field2 : Struct36,
	field3 : u256,
}


fn main() -> () {

	let mut bytes0 = Bytes::new();
	bytes0.push(248u8);
	bytes0.push(161u8);
	bytes0.push(34u8);

	let raw_slice0 = bytes0.as_raw_slice();

	let mut bytes1 = Bytes::new();
	bytes1.push(12u8);
	bytes1.push(21u8);
	bytes1.push(27u8);
    

    let v: Struct0 = Struct0 {field1 : 1457118056,field2 : Struct1 {field1 : 13662,field2 : raw_slice0,field3 : 1602,},field3 : bytes1,};
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Struct0>(encoded);
    log(v.field1 == decoded.field1);
	log(v.field2.field1 == decoded.field2.field1);
	log(Bytes::from(v.field2.field2) == Bytes::from(decoded.field2.field2));
	log(v.field2.field3 == decoded.field2.field3);
	log(v.field3 == decoded.field3);
	let mut bytes2 = Bytes::new();
	bytes2.push(137u8);
	bytes2.push(240u8);
    

    let v: Bytes = bytes2;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Bytes>(encoded);
    log(v == decoded);
    

    let v: String = String::from_ascii_str("72Hd");
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<String>(encoded);
    log(v == decoded);
	let mut bytes3 = Bytes::new();
	bytes3.push(241u8);
	bytes3.push(48u8);
	bytes3.push(72u8);
	bytes3.push(195u8);
	bytes3.push(189u8);

	let raw_slice1 = bytes3.as_raw_slice();
    

    let v: raw_slice = raw_slice1;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<raw_slice>(encoded);
    log(Bytes::from(v) == Bytes::from(decoded));
    

    let v: Struct2 = Struct2 {field1 : 51818,};
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Struct2>(encoded);
    log(v.field1 == decoded.field1);
	let mut bytes4 = Bytes::new();
	bytes4.push(228u8);
	bytes4.push(108u8);
	bytes4.push(231u8);
	bytes4.push(73u8);
	bytes4.push(164u8);

	let raw_slice2 = bytes4.as_raw_slice();

	let mut bytes5 = Bytes::new();
	bytes5.push(85u8);
	bytes5.push(154u8);

	let raw_slice3 = bytes5.as_raw_slice();

	let mut vector0 : Vec<raw_slice> = Vec::new();
	vector0.push(raw_slice2);
	vector0.push(raw_slice3);
    

    let v: Vec<raw_slice> = vector0;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Vec<raw_slice>>(encoded);
    log(Bytes::from(v.get(0).unwrap()) == Bytes::from(decoded.get(0).unwrap()));
	log(Bytes::from(v.get(1).unwrap()) == Bytes::from(decoded.get(1).unwrap()));
    

    let v: bool = false;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<bool>(encoded);
    log(v == decoded);
	let mut vector1 : Vec<str> = Vec::new();
	vector1.push("?q<");
    

    let v: Vec<str> = vector1;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Vec<str>>(encoded);
    log(v.get(0).unwrap() == decoded.get(0).unwrap());
    

    let v: str[5] = __to_str_array(",q-MM");
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<str[5]>(encoded);
    log(from_str_array(v) == from_str_array(decoded));
	let mut bytes6 = Bytes::new();
	bytes6.push(156u8);
	bytes6.push(27u8);
	bytes6.push(123u8);
	bytes6.push(187u8);
	bytes6.push(66u8);
    

    let v: Bytes = bytes6;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Bytes>(encoded);
    log(v == decoded);
    

    let v: [[(bool, b256); 1]; 2] = [[(false, 0xd5417038ddf8d781cf634d3d7e1b5d9ac21b08a581f7089bec50b38dd3193e86)], [(true, 0xa4a6f19cd09b0245a5ce05e1152c0a5a76bb45b1a834bf8e0ba6ffbf73070ac2)]];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[[(bool, b256); 1]; 2]>(encoded);
    log(v[0][0].0 == decoded[0][0].0);
	log(v[0][0].1 == decoded[0][0].1);
	log(v[1][0].0 == decoded[1][0].0);
	log(v[1][0].1 == decoded[1][0].1);
    

    let v: String = String::from_ascii_str("M");
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<String>(encoded);
    log(v == decoded);
    

    let v: str = "IM*";
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<str>(encoded);
    log(v == decoded);
    

    let v: (u16, Enum0, [u256; 2]) = (11565, Enum0::Variant1(__to_str_array("K,B")), [0x63bd469aae5a660980e0db1803bcc82a4dce0288fa9bf579720cbde2588c5468u256, 0xc5c48bcfc22406722b96e92b6f6234b88eab43e621bacac30d314542ce2a449fu256]);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<(u16, Enum0, [u256; 2])>(encoded);
    log(v.0 == decoded.0);
	log(from_str_array(v.1.get_Variant1()) == from_str_array(decoded.1.get_Variant1()));
	log(v.2[0] == decoded.2[0]);
	log(v.2[1] == decoded.2[1]);
	let mut vector2 : Vec<u16> = Vec::new();
	vector2.push(6751);
	vector2.push(44370);
	vector2.push(55772);
	vector2.push(47359);
	vector2.push(46147);

	let mut vector3 : Vec<str> = Vec::new();
	vector3.push("x");
    

    let v: Struct3 = Struct3 {field1 : "B",field2 : Enum2::Variant1((4291361961, 4097133765)),field3 : Struct5 {field1 : vector2,field2 : Enum3::Variant3(__to_str_array("mx?")),field3 : 210u8,field4 : vector3,},field4 : [3994538503],};
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Struct3>(encoded);
    log(v.field1 == decoded.field1);
	log(v.field2.get_Variant1().0 == decoded.field2.get_Variant1().0);
	log(v.field2.get_Variant1().1 == decoded.field2.get_Variant1().1);
	log(v.field3.field1.get(0).unwrap() == decoded.field3.field1.get(0).unwrap());
	log(v.field3.field1.get(1).unwrap() == decoded.field3.field1.get(1).unwrap());
	log(v.field3.field1.get(2).unwrap() == decoded.field3.field1.get(2).unwrap());
	log(v.field3.field1.get(3).unwrap() == decoded.field3.field1.get(3).unwrap());
	log(v.field3.field1.get(4).unwrap() == decoded.field3.field1.get(4).unwrap());
	log(from_str_array(v.field3.field2.get_Variant3()) == from_str_array(decoded.field3.field2.get_Variant3()));
	log(v.field3.field3 == decoded.field3.field3);
	log(v.field3.field4.get(0).unwrap() == decoded.field3.field4.get(0).unwrap());
	log(v.field4[0] == decoded.field4[0]);
	let mut bytes7 = Bytes::new();
	bytes7.push(220u8);
	bytes7.push(177u8);

	let mut bytes8 = Bytes::new();
	bytes8.push(38u8);
	bytes8.push(222u8);

	let mut bytes9 = Bytes::new();
	bytes9.push(10u8);
	bytes9.push(129u8);
	bytes9.push(14u8);

	let mut bytes10 = Bytes::new();
	bytes10.push(6u8);
	bytes10.push(102u8);
	bytes10.push(164u8);
	bytes10.push(127u8);
    

    let v: ([Bytes; 4], [(b256, str[1]); 2]) = ([bytes7, bytes8, bytes9, bytes10], [(0xdfcbe6eb727b7de2b3b83ea61be0066d022e7c6e0bd7e60c98d883d30d1746a4, __to_str_array(")")), (0xe45b94ed0c6b5124a2522d99755ae79a4d4a9003ed7d6052909a5ef38085a766, __to_str_array("h"))]);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<([Bytes; 4], [(b256, str[1]); 2])>(encoded);
    log(v.0[0] == decoded.0[0]);
	log(v.0[1] == decoded.0[1]);
	log(v.0[2] == decoded.0[2]);
	log(v.0[3] == decoded.0[3]);
	log(v.1[0].0 == decoded.1[0].0);
	log(from_str_array(v.1[0].1) == from_str_array(decoded.1[0].1));
	log(v.1[1].0 == decoded.1[1].0);
	log(from_str_array(v.1[1].1) == from_str_array(decoded.1[1].1));
	let mut bytes11 = Bytes::new();
	bytes11.push(17u8);
	bytes11.push(112u8);
    

    let v: (Bytes, b256) = (bytes11, 0x1171dc39016e07b385101e10b53315752ee705145617f05d1d1cdb13ace60714);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<(Bytes, b256)>(encoded);
    log(v.0 == decoded.0);
	log(v.1 == decoded.1);
	let mut bytes12 = Bytes::new();
	bytes12.push(112u8);
	bytes12.push(141u8);
	bytes12.push(0u8);
	bytes12.push(89u8);
	bytes12.push(123u8);

	let raw_slice4 = bytes12.as_raw_slice();

	let mut bytes13 = Bytes::new();
	bytes13.push(102u8);
	bytes13.push(38u8);
	bytes13.push(8u8);
    

    let v: (raw_slice, u64, Struct6, [u8; 4]) = (raw_slice4, 2835879063758962219, Struct6 {field1 : bytes13,}, [124u8, 182u8, 213u8, 2u8]);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<(raw_slice, u64, Struct6, [u8; 4])>(encoded);
    log(Bytes::from(v.0) == Bytes::from(decoded.0));
	log(v.1 == decoded.1);
	log(v.2.field1 == decoded.2.field1);
	log(v.3[0] == decoded.3[0]);
	log(v.3[1] == decoded.3[1]);
	log(v.3[2] == decoded.3[2]);
	log(v.3[3] == decoded.3[3]);
	let mut vector4 : Vec<b256> = Vec::new();
	vector4.push(0x840424296dfd6d4c0a64c8d9b980721bf3a6b9f1401aa9d2c5c0733f600bf61e);

	let mut vector5 : Vec<b256> = Vec::new();
	vector5.push(0x0a5cdfa73bd56cc66251bd61c5870600234cd6edf77c4bacb53eb7c02b74d282);
	vector5.push(0x1c3088abcce03fb446794351ce8a1169e70f31e6095346a14d87daff178604a2);
	vector5.push(0x44722f4213cd847e836919226095f2ab181dfb1f1c75200fe014cb49e1764a9d);
	vector5.push(0x8797b98161c2aba8c8cb83560202c9ff9ae598d52e66a3f91724818e34fcfd77);
	vector5.push(0x5021ea92e772948a1292fed48561d01973385d9a78a7bac37956e8ded32d51b1);

	let mut vector6 : Vec<b256> = Vec::new();
	vector6.push(0x69cff9ce9bb7f087cf68e77c3aad775631515a2734384a8a4f5724ea1fa4f4d9);
	vector6.push(0x8c3212d506a8aabdc5475e89e193f84b5de954db9dd5dbb7c811c92e29fbe7b3);
	vector6.push(0x0de1e899c91ee26e604faf33c6b44c0d52157531b961697a4be72a912bb1ab7f);
	vector6.push(0xb89efa4b8eec2a95945365cdf740052eb761c212d1fad2a5d630f58d1d9ea59e);
	vector6.push(0x0c24556d703bb2b1fb990f700ffcc8b99025dd9fe5750b1af55b3c083274b4f2);

	let mut vector7 : Vec<b256> = Vec::new();
	vector7.push(0x8dda7233af109d64e87f7bfb52572774ab9863e06482f2c6589314e2d37f4cab);
	vector7.push(0xfec03847b0b1aaa3dfc96a94c7b6c9235717f391a80646112634a18d7851f5b8);
	vector7.push(0xb7d2de348873e011cf70729be98b2fc37973a984b7c8af7cfaabe2e3771ae8d8);
	vector7.push(0x1f5499ea848c217c8da1837aee6c5925dfcc685d49836286a2d538b0fd5351ae);
	vector7.push(0x7d540379669c992f0776fc8d40a5a70bb566d020c04a3bf2665f4374718b402a);

	let mut vector8 : Vec<b256> = Vec::new();
	vector8.push(0x6c06f03978e468d7e2f65bc7a0d8d817ef9057f4d084ae13b8e7a87301665596);
	vector8.push(0x37f2f1b27b3db6096744a0d865466ff8da151521ddd9b6ab3b66f1edfb4d48d7);

	let mut vector9 : Vec<b256> = Vec::new();
	vector9.push(0xbf1e1aaa494bc40bc841e3c4aad9e455fa2f62f9fc4c727aeb31e31fc3f980c3);
	vector9.push(0xbe6b23bed318f5acdae773a5f945f3e3ce553a8b3e9170fbd48ecc37eb40feec);

	let mut vector10 : Vec<b256> = Vec::new();
	vector10.push(0x52b262609f9c29e557ad8fff09a159211446461c389cefcfb2732f75062d1363);
	vector10.push(0x483aaad5c4f6e9bafa3413401a3225304b91a4d57109b69a9f12da77c9ff27c3);
	vector10.push(0x5fd4b1a64ff37491025605eab1de794eadfbce5a1d2753ec40a1263fdd322f3c);
	vector10.push(0x4614d53e181fec36078df9d75d19a6212683a59bb29f1bab1f60bbbe4d4bdf48);

	let mut vector11 : Vec<b256> = Vec::new();
	vector11.push(0xb66ff4e8b3649d08627dbb520f712d5dd360c15d62dbc609fb1cea9449e74f4f);
	vector11.push(0x3bbbdb13f702e66868518b98e63a00b3324ecfe53df6f4abfaba846cc16bf5ba);

	let mut vector12 : Vec<b256> = Vec::new();
	vector12.push(0x53312e557213bb856bf91158622b47a9e24ac0802aa249f7b4aa10fdd9c1a920);
    

    let v: [[Vec<b256>; 3]; 3] = [[vector4, vector5, vector6], [vector7, vector8, vector9], [vector10, vector11, vector12]];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[[Vec<b256>; 3]; 3]>(encoded);
    log(v[0][0].get(0).unwrap() == decoded[0][0].get(0).unwrap());
	log(v[0][1].get(0).unwrap() == decoded[0][1].get(0).unwrap());
	log(v[0][1].get(1).unwrap() == decoded[0][1].get(1).unwrap());
	log(v[0][1].get(2).unwrap() == decoded[0][1].get(2).unwrap());
	log(v[0][1].get(3).unwrap() == decoded[0][1].get(3).unwrap());
	log(v[0][1].get(4).unwrap() == decoded[0][1].get(4).unwrap());
	log(v[0][2].get(0).unwrap() == decoded[0][2].get(0).unwrap());
	log(v[0][2].get(1).unwrap() == decoded[0][2].get(1).unwrap());
	log(v[0][2].get(2).unwrap() == decoded[0][2].get(2).unwrap());
	log(v[0][2].get(3).unwrap() == decoded[0][2].get(3).unwrap());
	log(v[0][2].get(4).unwrap() == decoded[0][2].get(4).unwrap());
	log(v[1][0].get(0).unwrap() == decoded[1][0].get(0).unwrap());
	log(v[1][0].get(1).unwrap() == decoded[1][0].get(1).unwrap());
	log(v[1][0].get(2).unwrap() == decoded[1][0].get(2).unwrap());
	log(v[1][0].get(3).unwrap() == decoded[1][0].get(3).unwrap());
	log(v[1][0].get(4).unwrap() == decoded[1][0].get(4).unwrap());
	log(v[1][1].get(0).unwrap() == decoded[1][1].get(0).unwrap());
	log(v[1][1].get(1).unwrap() == decoded[1][1].get(1).unwrap());
	log(v[1][2].get(0).unwrap() == decoded[1][2].get(0).unwrap());
	log(v[1][2].get(1).unwrap() == decoded[1][2].get(1).unwrap());
	log(v[2][0].get(0).unwrap() == decoded[2][0].get(0).unwrap());
	log(v[2][0].get(1).unwrap() == decoded[2][0].get(1).unwrap());
	log(v[2][0].get(2).unwrap() == decoded[2][0].get(2).unwrap());
	log(v[2][0].get(3).unwrap() == decoded[2][0].get(3).unwrap());
	log(v[2][1].get(0).unwrap() == decoded[2][1].get(0).unwrap());
	log(v[2][1].get(1).unwrap() == decoded[2][1].get(1).unwrap());
	log(v[2][2].get(0).unwrap() == decoded[2][2].get(0).unwrap());
	let mut bytes14 = Bytes::new();
	bytes14.push(204u8);
	bytes14.push(46u8);
	bytes14.push(196u8);
	bytes14.push(37u8);
	bytes14.push(98u8);
    

    let v: Bytes = bytes14;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Bytes>(encoded);
    log(v == decoded);
    

    let v: u32 = 3003528205;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u32>(encoded);
    log(v == decoded);
    

    let v: Enum4 = Enum4::Variant2(true);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum4>(encoded);
    log(v.get_Variant2() == decoded.get_Variant2());
    

    let v: str = "";
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<str>(encoded);
    log(v == decoded);
	let mut bytes15 = Bytes::new();
	bytes15.push(28u8);
	bytes15.push(84u8);
	bytes15.push(82u8);
	bytes15.push(96u8);
	bytes15.push(170u8);
    

    let v: [Bytes; 1] = [bytes15];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[Bytes; 1]>(encoded);
    log(v[0] == decoded[0]);
    

    let v: u256 = 0xffcec8d9df1ff0bfc3e139e5eee2f537bcf8c0f24e65d30ec1186770172f5edfu256;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u256>(encoded);
    log(v == decoded);
	let mut bytes16 = Bytes::new();
	bytes16.push(111u8);
	bytes16.push(65u8);
	bytes16.push(173u8);
	bytes16.push(22u8);
	bytes16.push(146u8);

	let raw_slice5 = bytes16.as_raw_slice();

	let mut bytes17 = Bytes::new();
	bytes17.push(146u8);
	bytes17.push(44u8);
	bytes17.push(170u8);

	let raw_slice6 = bytes17.as_raw_slice();

	let mut bytes18 = Bytes::new();
	bytes18.push(137u8);
	bytes18.push(165u8);

	let raw_slice7 = bytes18.as_raw_slice();

	let mut bytes19 = Bytes::new();
	bytes19.push(215u8);
	bytes19.push(236u8);
	bytes19.push(95u8);

	let raw_slice8 = bytes19.as_raw_slice();
    

    let v: [(u32, raw_slice); 4] = [(353192544, raw_slice5), (2823901838, raw_slice6), (3429535436, raw_slice7), (2797498839, raw_slice8)];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[(u32, raw_slice); 4]>(encoded);
    log(v[0].0 == decoded[0].0);
	log(Bytes::from(v[0].1) == Bytes::from(decoded[0].1));
	log(v[1].0 == decoded[1].0);
	log(Bytes::from(v[1].1) == Bytes::from(decoded[1].1));
	log(v[2].0 == decoded[2].0);
	log(Bytes::from(v[2].1) == Bytes::from(decoded[2].1));
	log(v[3].0 == decoded[3].0);
	log(Bytes::from(v[3].1) == Bytes::from(decoded[3].1));
	let mut vector13 : Vec<str[4]> = Vec::new();
	vector13.push(__to_str_array("%D*"));
	vector13.push(__to_str_array("~aQ"));
	vector13.push(__to_str_array("H3!"));
	vector13.push(__to_str_array(" ["));
    

    let v: Struct8 = Struct8 {field1 : vector13,};
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Struct8>(encoded);
    log(from_str_array(v.field1.get(0).unwrap()) == from_str_array(decoded.field1.get(0).unwrap()));
	log(from_str_array(v.field1.get(1).unwrap()) == from_str_array(decoded.field1.get(1).unwrap()));
	log(from_str_array(v.field1.get(2).unwrap()) == from_str_array(decoded.field1.get(2).unwrap()));
	log(from_str_array(v.field1.get(3).unwrap()) == from_str_array(decoded.field1.get(3).unwrap()));
    

    let v: bool = true;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<bool>(encoded);
    log(v == decoded);
	let mut bytes20 = Bytes::new();
	bytes20.push(184u8);

	let raw_slice9 = bytes20.as_raw_slice();

	let mut vector14 : Vec<str> = Vec::new();
	vector14.push("[4");
    

    let v: Struct9 = Struct9 {field1 : raw_slice9,field2 : 0x1ae2f9aef58007deb8273787898ef8a8755a260d4f26ac141e349d9acad8e8efu256,field3 : (vector14, 0x6dda7ce086fe60f603bf8ca3ba5b03107e8a73b44cf48f4f34304c3041086ed5u256, true, "z,"),field4 : 3385729627,};
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Struct9>(encoded);
    log(Bytes::from(v.field1) == Bytes::from(decoded.field1));
	log(v.field2 == decoded.field2);
	log(v.field3.0.get(0).unwrap() == decoded.field3.0.get(0).unwrap());
	log(v.field3.1 == decoded.field3.1);
	log(v.field3.2 == decoded.field3.2);
	log(v.field3.3 == decoded.field3.3);
	log(v.field4 == decoded.field4);
    

    let v: [u256; 2] = [0x9fec41bc96e418a1879627cd90d1df41fd94e0f4f7ce0fb4ec1319ce781db8bbu256, 0x3f1f44787d5ab4926c11b0e1c19d71115a843af5d0685ffb9967f9c16bd1f89bu256];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[u256; 2]>(encoded);
    log(v[0] == decoded[0]);
	log(v[1] == decoded[1]);
    

    let v: [u256; 4] = [0xe54a15e5733ee853630e6fd2133a04732bf46b2bed3e3818a44c394051668a18u256, 0x63f3bf4639f06988e1ccdd40a2a1df8336a8d68c7790a3e2e70491820a02179du256, 0xaddc8cbca476a1795f44c7fe0525ce913571c5edaaa8a9e347e58c2531e9ce31u256, 0x480df40484bcf67b61796aedb8073b3a6813ac51d0384e0c1cc4cb99ec010b96u256];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[u256; 4]>(encoded);
    log(v[0] == decoded[0]);
	log(v[1] == decoded[1]);
	log(v[2] == decoded[2]);
	log(v[3] == decoded[3]);
    

    let v: u32 = 581276889;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u32>(encoded);
    log(v == decoded);
    

    let v: str = "}R";
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<str>(encoded);
    log(v == decoded);
    

    let v: Enum7 = Enum7::Variant2(Enum10::Variant2((2842228011, 240u8, false)));
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum7>(encoded);
    log(v.get_Variant2().get_Variant2().0 == decoded.get_Variant2().get_Variant2().0);
	log(v.get_Variant2().get_Variant2().1 == decoded.get_Variant2().get_Variant2().1);
	log(v.get_Variant2().get_Variant2().2 == decoded.get_Variant2().get_Variant2().2);
    

    let v: b256 = 0x25e3ad64fcd7f58bf3e91c9e12caab9619a800b2eb40b1024a1eee208a2492c2;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<b256>(encoded);
    log(v == decoded);
	let mut vector15 : Vec<u32> = Vec::new();
	vector15.push(1609834033);
	vector15.push(1189437745);
    

    let v: Struct11 = Struct11 {field1 : Struct12 {field1 : 16453706368804166274,field2 : String::from_ascii_str("7k"),},field2 : (0xbe18ff14f4a49d965e7e1318182673e2a88938f5356b6757ee14b310f91fcc5du256, vector15, [6020535651526890309, 16445525490470441517, 7430167120869396717], Enum11::Variant1(String::from_ascii_str("*h0")), [193u8, 58u8, 121u8, 7u8, 180u8]),};
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Struct11>(encoded);
    log(v.field1.field1 == decoded.field1.field1);
	log(v.field1.field2 == decoded.field1.field2);
	log(v.field2.0 == decoded.field2.0);
	log(v.field2.1.get(0).unwrap() == decoded.field2.1.get(0).unwrap());
	log(v.field2.1.get(1).unwrap() == decoded.field2.1.get(1).unwrap());
	log(v.field2.2[0] == decoded.field2.2[0]);
	log(v.field2.2[1] == decoded.field2.2[1]);
	log(v.field2.2[2] == decoded.field2.2[2]);
	log(v.field2.3.get_Variant1() == decoded.field2.3.get_Variant1());
	log(v.field2.4[0] == decoded.field2.4[0]);
	log(v.field2.4[1] == decoded.field2.4[1]);
	log(v.field2.4[2] == decoded.field2.4[2]);
	log(v.field2.4[3] == decoded.field2.4[3]);
	log(v.field2.4[4] == decoded.field2.4[4]);
	let mut vector16 : Vec<str[1]> = Vec::new();
	vector16.push(__to_str_array("d"));

	let mut bytes21 = Bytes::new();
	bytes21.push(89u8);
	bytes21.push(188u8);
	bytes21.push(65u8);
	bytes21.push(131u8);
    

    let v: Struct13 = Struct13 {field1 : vector16,field2 : 2216273423,field3 : bytes21,field4 : 0x64c9eb2f997c74250d3c7d68874e7af8c3b6116c80e2011667fdd149b59e5e71u256,field5 : Enum12::Variant4(2135484404),};
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Struct13>(encoded);
    log(from_str_array(v.field1.get(0).unwrap()) == from_str_array(decoded.field1.get(0).unwrap()));
	log(v.field2 == decoded.field2);
	log(v.field3 == decoded.field3);
	log(v.field4 == decoded.field4);
	log(v.field5.get_Variant4() == decoded.field5.get_Variant4());
	let mut vector17 : Vec<u32> = Vec::new();
	vector17.push(2746678249);
	vector17.push(4124345415);
	vector17.push(374888131);
	vector17.push(3194347478);
    

    let v: (Vec<u32>, [u256; 3], u8, u8) = (vector17, [0x32a61a29c1cd2ed6fb9717a3a1c2773585afa7218dbea992bd3ed51ef2369853u256, 0x5dd3c7fe0e8f3462b29ee1ac6579bf7e6ba65fff131537a10f4569a4ffbfc578u256, 0x2171ffaa191ab48d3082323c6a52a97822e4324603dd8924a38277807aa35de8u256], 14u8, 244u8);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<(Vec<u32>, [u256; 3], u8, u8)>(encoded);
    log(v.0.get(0).unwrap() == decoded.0.get(0).unwrap());
	log(v.0.get(1).unwrap() == decoded.0.get(1).unwrap());
	log(v.0.get(2).unwrap() == decoded.0.get(2).unwrap());
	log(v.0.get(3).unwrap() == decoded.0.get(3).unwrap());
	log(v.1[0] == decoded.1[0]);
	log(v.1[1] == decoded.1[1]);
	log(v.1[2] == decoded.1[2]);
	log(v.2 == decoded.2);
	log(v.3 == decoded.3);
    

    let v: str = "u";
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<str>(encoded);
    log(v == decoded);
	let mut vector18 : Vec<b256> = Vec::new();
	vector18.push(0xc6df59a1ca074f90f0ddb6dec19371a8150fee58b24ed63a16467ffa674dbc5b);
	vector18.push(0x6062bc167872aed361a3f0ca7e00e18c53786c1451b50afc86ae1765edca29ef);
	vector18.push(0xd089d424f96512c86026b53b6809d80b03e65cda6f68088edb49266d94c92e54);
	vector18.push(0x6dc1ed92be3b93d95ce929a7ad2474f40c994ce70d120987ec687173c279d853);
	vector18.push(0xf79bfb9c0683ed9ef5f6ff7cb726d4e5d97ca5d6654ec1ba50d3e38bbd1bff4f);

	let mut bytes22 = Bytes::new();
	bytes22.push(158u8);
	bytes22.push(148u8);
	bytes22.push(93u8);
    

    let v: Struct14 = Struct14 {field1 : (Enum13::Variant1(10677), vector18, [152u8, 37u8, 17u8, 125u8], bytes22),field2 : 3107172304,};
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Struct14>(encoded);
    log(v.field1.0.get_Variant1() == decoded.field1.0.get_Variant1());
	log(v.field1.1.get(0).unwrap() == decoded.field1.1.get(0).unwrap());
	log(v.field1.1.get(1).unwrap() == decoded.field1.1.get(1).unwrap());
	log(v.field1.1.get(2).unwrap() == decoded.field1.1.get(2).unwrap());
	log(v.field1.1.get(3).unwrap() == decoded.field1.1.get(3).unwrap());
	log(v.field1.1.get(4).unwrap() == decoded.field1.1.get(4).unwrap());
	log(v.field1.2[0] == decoded.field1.2[0]);
	log(v.field1.2[1] == decoded.field1.2[1]);
	log(v.field1.2[2] == decoded.field1.2[2]);
	log(v.field1.2[3] == decoded.field1.2[3]);
	log(v.field1.3 == decoded.field1.3);
	log(v.field2 == decoded.field2);
    

    let v: Enum14 = Enum14::Variant1((0x695b2b314bbe4ee0f7f745fd266c6fe0702aaf2edcedacba69a650d66999e201, Struct15 {field1 : 0x7eb5b003b5b3e7dfac3a19bd1d203015bc1f3f1ffdca4fbc2f190c5909cfeb69u256,field2 : true,}, 0x7e7b32e6ff3d8be6c4a02d082e167d79337ad1f168151980e1ad64c9f00e7b17));
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum14>(encoded);
    log(v.get_Variant1().0 == decoded.get_Variant1().0);
	log(v.get_Variant1().1.field1 == decoded.get_Variant1().1.field1);
	log(v.get_Variant1().1.field2 == decoded.get_Variant1().1.field2);
	log(v.get_Variant1().2 == decoded.get_Variant1().2);
    

    let v: Enum15 = Enum15::Variant1(__to_str_array("v^"));
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum15>(encoded);
    log(from_str_array(v.get_Variant1()) == from_str_array(decoded.get_Variant1()));
    

    let v: b256 = 0x7a654801feb533f1273ff7c4b8feaec0ee31d6c87df68c1939d03a48ec8bdb2e;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<b256>(encoded);
    log(v == decoded);
    

    let v: u256 = 0xf49ab415be785528e2d5e3ee2c9ad192cbd01987f3c33963df340e996da49925u256;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u256>(encoded);
    log(v == decoded);
    

    let v: u16 = 57254;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u16>(encoded);
    log(v == decoded);
	let mut bytes23 = Bytes::new();
	bytes23.push(169u8);

	let raw_slice10 = bytes23.as_raw_slice();

	let mut bytes24 = Bytes::new();
	bytes24.push(19u8);
	bytes24.push(250u8);
	bytes24.push(225u8);
	bytes24.push(76u8);
    

    let v: Struct17 = Struct17 {field1 : raw_slice10,field2 : Enum16::Variant1(Struct18 {field1 : 7519658325020514104,field2 : bytes24,}),field3 : Enum18::Variant2(3972941339),};
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Struct17>(encoded);
    log(Bytes::from(v.field1) == Bytes::from(decoded.field1));
	log(v.field2.get_Variant1().field1 == decoded.field2.get_Variant1().field1);
	log(v.field2.get_Variant1().field2 == decoded.field2.get_Variant1().field2);
	log(v.field3.get_Variant2() == decoded.field3.get_Variant2());
	let mut bytes25 = Bytes::new();
	bytes25.push(80u8);

	let mut vector19 : Vec<u32> = Vec::new();
	vector19.push(1907725314);

	let mut vector20 : Vec<str[5]> = Vec::new();
	vector20.push(__to_str_array("?T>*"));
	vector20.push(__to_str_array("H@Pg"));

	let mut bytes26 = Bytes::new();
	bytes26.push(61u8);

	let raw_slice11 = bytes26.as_raw_slice();

	let mut bytes27 = Bytes::new();
	bytes27.push(168u8);
	bytes27.push(190u8);
	bytes27.push(255u8);

	let raw_slice12 = bytes27.as_raw_slice();

	let mut bytes28 = Bytes::new();
	bytes28.push(85u8);
	bytes28.push(66u8);
	bytes28.push(217u8);

	let raw_slice13 = bytes28.as_raw_slice();

	let mut bytes29 = Bytes::new();
	bytes29.push(45u8);
	bytes29.push(16u8);

	let raw_slice14 = bytes29.as_raw_slice();

	let mut bytes30 = Bytes::new();
	bytes30.push(84u8);

	let raw_slice15 = bytes30.as_raw_slice();
    

    let v: ([[u32; 3]; 5], (str, Bytes, Vec<u32>, Vec<str[5]>, [raw_slice; 5])) = ([[696749141, 1377256284, 3537557810], [1905905490, 1554058054, 4249056567], [1130942242, 2475508633, 4189914144], [2121870388, 1611045976, 929106123], [773698814, 3683511943, 1068294978]], ("CH$:", bytes25, vector19, vector20, [raw_slice11, raw_slice12, raw_slice13, raw_slice14, raw_slice15]));
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<([[u32; 3]; 5], (str, Bytes, Vec<u32>, Vec<str[5]>, [raw_slice; 5]))>(encoded);
    log(v.0[0][0] == decoded.0[0][0]);
	log(v.0[0][1] == decoded.0[0][1]);
	log(v.0[0][2] == decoded.0[0][2]);
	log(v.0[1][0] == decoded.0[1][0]);
	log(v.0[1][1] == decoded.0[1][1]);
	log(v.0[1][2] == decoded.0[1][2]);
	log(v.0[2][0] == decoded.0[2][0]);
	log(v.0[2][1] == decoded.0[2][1]);
	log(v.0[2][2] == decoded.0[2][2]);
	log(v.0[3][0] == decoded.0[3][0]);
	log(v.0[3][1] == decoded.0[3][1]);
	log(v.0[3][2] == decoded.0[3][2]);
	log(v.0[4][0] == decoded.0[4][0]);
	log(v.0[4][1] == decoded.0[4][1]);
	log(v.0[4][2] == decoded.0[4][2]);
	log(v.1.0 == decoded.1.0);
	log(v.1.1 == decoded.1.1);
	log(v.1.2.get(0).unwrap() == decoded.1.2.get(0).unwrap());
	log(from_str_array(v.1.3.get(0).unwrap()) == from_str_array(decoded.1.3.get(0).unwrap()));
	log(from_str_array(v.1.3.get(1).unwrap()) == from_str_array(decoded.1.3.get(1).unwrap()));
	log(Bytes::from(v.1.4[0]) == Bytes::from(decoded.1.4[0]));
	log(Bytes::from(v.1.4[1]) == Bytes::from(decoded.1.4[1]));
	log(Bytes::from(v.1.4[2]) == Bytes::from(decoded.1.4[2]));
	log(Bytes::from(v.1.4[3]) == Bytes::from(decoded.1.4[3]));
	log(Bytes::from(v.1.4[4]) == Bytes::from(decoded.1.4[4]));
	let mut bytes31 = Bytes::new();
	bytes31.push(65u8);
	bytes31.push(91u8);
	bytes31.push(237u8);
	bytes31.push(121u8);

	let mut vector22 : Vec<u16> = Vec::new();
	vector22.push(8822);

	let mut vector23 : Vec<u16> = Vec::new();
	vector23.push(46831);
	vector23.push(13436);
	vector23.push(4144);
	vector23.push(42399);

	let mut vector24 : Vec<u16> = Vec::new();
	vector24.push(59549);
	vector24.push(1117);
	vector24.push(14906);
	vector24.push(39991);

	let mut vector21 : Vec<Vec<u16>> = Vec::new();
	vector21.push(vector22);
	vector21.push(vector23);
	vector21.push(vector24);

	let mut bytes32 = Bytes::new();
	bytes32.push(137u8);
	bytes32.push(146u8);
	bytes32.push(42u8);

	let mut bytes33 = Bytes::new();
	bytes33.push(10u8);

	let mut bytes34 = Bytes::new();
	bytes34.push(115u8);
	bytes34.push(131u8);
	bytes34.push(21u8);
	bytes34.push(50u8);
	bytes34.push(224u8);

	let mut bytes35 = Bytes::new();
	bytes35.push(8u8);
	bytes35.push(73u8);
	bytes35.push(252u8);
	bytes35.push(79u8);
	bytes35.push(186u8);

	let mut vector25 : Vec<Bytes> = Vec::new();
	vector25.push(bytes32);
	vector25.push(bytes33);
	vector25.push(bytes34);
	vector25.push(bytes35);

	let mut bytes36 = Bytes::new();
	bytes36.push(11u8);
	bytes36.push(52u8);
	bytes36.push(197u8);
	bytes36.push(154u8);

	let mut bytes37 = Bytes::new();
	bytes37.push(205u8);
	bytes37.push(14u8);
	bytes37.push(195u8);
	bytes37.push(176u8);
	bytes37.push(81u8);

	let mut bytes38 = Bytes::new();
	bytes38.push(177u8);
	bytes38.push(47u8);
	bytes38.push(172u8);
	bytes38.push(9u8);

	let mut bytes39 = Bytes::new();
	bytes39.push(68u8);
	bytes39.push(205u8);
	bytes39.push(82u8);

	let mut vector26 : Vec<Bytes> = Vec::new();
	vector26.push(bytes36);
	vector26.push(bytes37);
	vector26.push(bytes38);
	vector26.push(bytes39);
    

    let v: Struct19 = Struct19 {field1 : Enum19::Variant4(Struct20 {field1 : 215u8,field2 : 0x9ba5fad7a1085dc5613248065b161f69ef93730817ddffc2e8e8c71443fe434u256,field3 : bytes31,}),field2 : vector21,field3 : 67u8,field4 : vector25,field5 : vector26,};
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Struct19>(encoded);
    log(v.field1.get_Variant4().field1 == decoded.field1.get_Variant4().field1);
	log(v.field1.get_Variant4().field2 == decoded.field1.get_Variant4().field2);
	log(v.field1.get_Variant4().field3 == decoded.field1.get_Variant4().field3);
	log(v.field2.get(0).unwrap().get(0).unwrap() == decoded.field2.get(0).unwrap().get(0).unwrap());
	log(v.field2.get(1).unwrap().get(0).unwrap() == decoded.field2.get(1).unwrap().get(0).unwrap());
	log(v.field2.get(1).unwrap().get(1).unwrap() == decoded.field2.get(1).unwrap().get(1).unwrap());
	log(v.field2.get(1).unwrap().get(2).unwrap() == decoded.field2.get(1).unwrap().get(2).unwrap());
	log(v.field2.get(1).unwrap().get(3).unwrap() == decoded.field2.get(1).unwrap().get(3).unwrap());
	log(v.field2.get(2).unwrap().get(0).unwrap() == decoded.field2.get(2).unwrap().get(0).unwrap());
	log(v.field2.get(2).unwrap().get(1).unwrap() == decoded.field2.get(2).unwrap().get(1).unwrap());
	log(v.field2.get(2).unwrap().get(2).unwrap() == decoded.field2.get(2).unwrap().get(2).unwrap());
	log(v.field2.get(2).unwrap().get(3).unwrap() == decoded.field2.get(2).unwrap().get(3).unwrap());
	log(v.field3 == decoded.field3);
	log(v.field4.get(0).unwrap() == decoded.field4.get(0).unwrap());
	log(v.field4.get(1).unwrap() == decoded.field4.get(1).unwrap());
	log(v.field4.get(2).unwrap() == decoded.field4.get(2).unwrap());
	log(v.field4.get(3).unwrap() == decoded.field4.get(3).unwrap());
	log(v.field5.get(0).unwrap() == decoded.field5.get(0).unwrap());
	log(v.field5.get(1).unwrap() == decoded.field5.get(1).unwrap());
	log(v.field5.get(2).unwrap() == decoded.field5.get(2).unwrap());
	log(v.field5.get(3).unwrap() == decoded.field5.get(3).unwrap());
	let mut bytes40 = Bytes::new();
	bytes40.push(227u8);
	bytes40.push(4u8);
    

    let v: Bytes = bytes40;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Bytes>(encoded);
    log(v == decoded);
    

    let v: u8 = 148u8;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u8>(encoded);
    log(v == decoded);
    

    let v: u32 = 1440437334;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u32>(encoded);
    log(v == decoded);
    

    let v: str = "#";
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<str>(encoded);
    log(v == decoded);
    

    let v: [(u32, [str[1]; 5], str[3], (u256, u16)); 2] = [(1922479330, [__to_str_array(""), __to_str_array("r"), __to_str_array("D"), __to_str_array("p"), __to_str_array("?")], __to_str_array("dv"), (0x5eb46f67c79b93d3a40180da07a8175465d467966d5facf45ac689e375b79c26u256, 2517)), (1052548504, [__to_str_array(""), __to_str_array("H"), __to_str_array("B"), __to_str_array(""), __to_str_array("*")], __to_str_array("vcd"), (0x57eab5ebb82a946a8af8058d64083584d5d9ec99ad3456d6831d40cce69baa4au256, 3644))];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[(u32, [str[1]; 5], str[3], (u256, u16)); 2]>(encoded);
    log(v[0].0 == decoded[0].0);
	log(from_str_array(v[0].1[0]) == from_str_array(decoded[0].1[0]));
	log(from_str_array(v[0].1[1]) == from_str_array(decoded[0].1[1]));
	log(from_str_array(v[0].1[2]) == from_str_array(decoded[0].1[2]));
	log(from_str_array(v[0].1[3]) == from_str_array(decoded[0].1[3]));
	log(from_str_array(v[0].1[4]) == from_str_array(decoded[0].1[4]));
	log(from_str_array(v[0].2) == from_str_array(decoded[0].2));
	log(v[0].3.0 == decoded[0].3.0);
	log(v[0].3.1 == decoded[0].3.1);
	log(v[1].0 == decoded[1].0);
	log(from_str_array(v[1].1[0]) == from_str_array(decoded[1].1[0]));
	log(from_str_array(v[1].1[1]) == from_str_array(decoded[1].1[1]));
	log(from_str_array(v[1].1[2]) == from_str_array(decoded[1].1[2]));
	log(from_str_array(v[1].1[3]) == from_str_array(decoded[1].1[3]));
	log(from_str_array(v[1].1[4]) == from_str_array(decoded[1].1[4]));
	log(from_str_array(v[1].2) == from_str_array(decoded[1].2));
	log(v[1].3.0 == decoded[1].3.0);
	log(v[1].3.1 == decoded[1].3.1);
    

    let v: u8 = 24u8;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u8>(encoded);
    log(v == decoded);
    

    let v: str = "6";
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<str>(encoded);
    log(v == decoded);
	let mut bytes41 = Bytes::new();
	bytes41.push(202u8);
    

    let v: Enum21 = Enum21::Variant1(Struct21 {field1 : (String::from_ascii_str("`1W"), 117u8, bytes41, String::from_ascii_str("y")),field2 : __to_str_array("&lK="),});
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum21>(encoded);
    log(v.get_Variant1().field1.0 == decoded.get_Variant1().field1.0);
	log(v.get_Variant1().field1.1 == decoded.get_Variant1().field1.1);
	log(v.get_Variant1().field1.2 == decoded.get_Variant1().field1.2);
	log(v.get_Variant1().field1.3 == decoded.get_Variant1().field1.3);
	log(from_str_array(v.get_Variant1().field2) == from_str_array(decoded.get_Variant1().field2));
    

    let v: u256 = 0xb4ef9e88bd8f5fe2da9e37442a30225cbf7c561ff07db8253f223e1a31649a58u256;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u256>(encoded);
    log(v == decoded);
	let mut vector27 : Vec<u256> = Vec::new();
	vector27.push(0x10105fd0181d54fa9afdb0026b4aba8bfcf58ee4c31343d4d530d15b64ac7bb4u256);
	vector27.push(0x7159311c41c3a54164a134db2a0b6a8e840a314e3886b074f62877d27ae945deu256);
    

    let v: Vec<u256> = vector27;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Vec<u256>>(encoded);
    log(v.get(0).unwrap() == decoded.get(0).unwrap());
	log(v.get(1).unwrap() == decoded.get(1).unwrap());
	let mut bytes42 = Bytes::new();
	bytes42.push(227u8);
	bytes42.push(136u8);

	let mut bytes43 = Bytes::new();
	bytes43.push(82u8);
	bytes43.push(201u8);
	bytes43.push(255u8);
	bytes43.push(155u8);

	let mut bytes44 = Bytes::new();
	bytes44.push(250u8);
	bytes44.push(208u8);

	let mut bytes45 = Bytes::new();
	bytes45.push(163u8);
	bytes45.push(64u8);
	bytes45.push(199u8);
	bytes45.push(209u8);

	let mut vector28 : Vec<Bytes> = Vec::new();
	vector28.push(bytes43);
	vector28.push(bytes44);
	vector28.push(bytes45);

	let mut bytes46 = Bytes::new();
	bytes46.push(196u8);
	bytes46.push(252u8);

	let raw_slice16 = bytes46.as_raw_slice();

	let mut bytes47 = Bytes::new();
	bytes47.push(141u8);
	bytes47.push(47u8);

	let raw_slice17 = bytes47.as_raw_slice();

	let mut bytes48 = Bytes::new();
	bytes48.push(200u8);

	let raw_slice18 = bytes48.as_raw_slice();

	let mut bytes49 = Bytes::new();
	bytes49.push(154u8);

	let raw_slice19 = bytes49.as_raw_slice();

	let mut bytes50 = Bytes::new();
	bytes50.push(196u8);
	bytes50.push(58u8);
	bytes50.push(120u8);
	bytes50.push(44u8);
	bytes50.push(60u8);

	let mut vector29 : Vec<u16> = Vec::new();
	vector29.push(13968);
	vector29.push(18437);
	vector29.push(31048);
	vector29.push(15040);
	vector29.push(3077);

	let mut vector30 : Vec<String> = Vec::new();
	vector30.push(String::from_ascii_str("*"));
	vector30.push(String::from_ascii_str("*f_"));
	vector30.push(String::from_ascii_str("BC"));
	vector30.push(String::from_ascii_str(" k"));
    

    let v: (Bytes, Enum22, Struct22, ((u32, b256, str[1]), raw_slice, (raw_slice, u64, raw_slice, u256, u64), String, (u256, u16, raw_slice)), Struct23) = (bytes42, Enum22::Variant3(vector28), Struct22 {field1 : 129u8,field2 : Enum23::Variant1(78u8),field3 : 183u8,field4 : __to_str_array("*|0"),}, ((1394711471, 0xf5e3754fb93df9c871ac3bf5e68f24e7cb7700e87ba3148852bfe6b791aaa484, __to_str_array("")), raw_slice16, (raw_slice17, 7277153634769008222, raw_slice18, 0xe00198f3fec5c3990e514bb0642d1e885740ee8a44ea52c0e1274627c5e571eeu256, 13436627358273380415), String::from_ascii_str(" c"), (0x8b705af0d3cf9330e9e7af05e96c8b7c51d144f9dbd811a8435dc7445ca24667u256, 24261, raw_slice19)), Struct23 {field1 : Struct24 {field1 : bytes50,},field2 : vector29,field3 : vector30,field4 : ["p", "QwR7", "", "|]*", "*?[)a"],field5 : (65u8, 0x4fdba26c7738afcb944a05a546b30122a6a04bdf33a214b1352f100593721718u256, 121u8, "F"),});
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<(Bytes, Enum22, Struct22, ((u32, b256, str[1]), raw_slice, (raw_slice, u64, raw_slice, u256, u64), String, (u256, u16, raw_slice)), Struct23)>(encoded);
    log(v.0 == decoded.0);
	log(v.1.get_Variant3().get(0).unwrap() == decoded.1.get_Variant3().get(0).unwrap());
	log(v.1.get_Variant3().get(1).unwrap() == decoded.1.get_Variant3().get(1).unwrap());
	log(v.1.get_Variant3().get(2).unwrap() == decoded.1.get_Variant3().get(2).unwrap());
	log(v.2.field1 == decoded.2.field1);
	log(v.2.field2.get_Variant1() == decoded.2.field2.get_Variant1());
	log(v.2.field3 == decoded.2.field3);
	log(from_str_array(v.2.field4) == from_str_array(decoded.2.field4));
	log(v.3.0.0 == decoded.3.0.0);
	log(v.3.0.1 == decoded.3.0.1);
	log(from_str_array(v.3.0.2) == from_str_array(decoded.3.0.2));
	log(Bytes::from(v.3.1) == Bytes::from(decoded.3.1));
	log(Bytes::from(v.3.2.0) == Bytes::from(decoded.3.2.0));
	log(v.3.2.1 == decoded.3.2.1);
	log(Bytes::from(v.3.2.2) == Bytes::from(decoded.3.2.2));
	log(v.3.2.3 == decoded.3.2.3);
	log(v.3.2.4 == decoded.3.2.4);
	log(v.3.3 == decoded.3.3);
	log(v.3.4.0 == decoded.3.4.0);
	log(v.3.4.1 == decoded.3.4.1);
	log(Bytes::from(v.3.4.2) == Bytes::from(decoded.3.4.2));
	log(v.4.field1.field1 == decoded.4.field1.field1);
	log(v.4.field2.get(0).unwrap() == decoded.4.field2.get(0).unwrap());
	log(v.4.field2.get(1).unwrap() == decoded.4.field2.get(1).unwrap());
	log(v.4.field2.get(2).unwrap() == decoded.4.field2.get(2).unwrap());
	log(v.4.field2.get(3).unwrap() == decoded.4.field2.get(3).unwrap());
	log(v.4.field2.get(4).unwrap() == decoded.4.field2.get(4).unwrap());
	log(v.4.field3.get(0).unwrap() == decoded.4.field3.get(0).unwrap());
	log(v.4.field3.get(1).unwrap() == decoded.4.field3.get(1).unwrap());
	log(v.4.field3.get(2).unwrap() == decoded.4.field3.get(2).unwrap());
	log(v.4.field3.get(3).unwrap() == decoded.4.field3.get(3).unwrap());
	log(v.4.field4[0] == decoded.4.field4[0]);
	log(v.4.field4[1] == decoded.4.field4[1]);
	log(v.4.field4[2] == decoded.4.field4[2]);
	log(v.4.field4[3] == decoded.4.field4[3]);
	log(v.4.field4[4] == decoded.4.field4[4]);
	log(v.4.field5.0 == decoded.4.field5.0);
	log(v.4.field5.1 == decoded.4.field5.1);
	log(v.4.field5.2 == decoded.4.field5.2);
	log(v.4.field5.3 == decoded.4.field5.3);
    

    let v: str[1] = __to_str_array("|");
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<str[1]>(encoded);
    log(from_str_array(v) == from_str_array(decoded));
	let mut vector31 : Vec<String> = Vec::new();
	vector31.push(String::from_ascii_str("]X"));
	vector31.push(String::from_ascii_str("rD4"));

	let mut vector32 : Vec<String> = Vec::new();
	vector32.push(String::from_ascii_str(";"));
	vector32.push(String::from_ascii_str("aO?"));
	vector32.push(String::from_ascii_str("kYN "));
	vector32.push(String::from_ascii_str("`y1"));

	let mut vector33 : Vec<String> = Vec::new();
	vector33.push(String::from_ascii_str("*G"));
	vector33.push(String::from_ascii_str("yi]A"));
	vector33.push(String::from_ascii_str("}"));

	let mut vector34 : Vec<String> = Vec::new();
	vector34.push(String::from_ascii_str("i"));
	vector34.push(String::from_ascii_str("*6 A"));
	vector34.push(String::from_ascii_str("0X"));
	vector34.push(String::from_ascii_str("11}"));
	vector34.push(String::from_ascii_str("tx"));
    

    let v: [Struct25; 4] = [Struct25 {field1 : true,field2 : vector31,}, Struct25 {field1 : true,field2 : vector32,}, Struct25 {field1 : true,field2 : vector33,}, Struct25 {field1 : false,field2 : vector34,}];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[Struct25; 4]>(encoded);
    log(v[0].field1 == decoded[0].field1);
	log(v[0].field2.get(0).unwrap() == decoded[0].field2.get(0).unwrap());
	log(v[0].field2.get(1).unwrap() == decoded[0].field2.get(1).unwrap());
	log(v[1].field1 == decoded[1].field1);
	log(v[1].field2.get(0).unwrap() == decoded[1].field2.get(0).unwrap());
	log(v[1].field2.get(1).unwrap() == decoded[1].field2.get(1).unwrap());
	log(v[1].field2.get(2).unwrap() == decoded[1].field2.get(2).unwrap());
	log(v[1].field2.get(3).unwrap() == decoded[1].field2.get(3).unwrap());
	log(v[2].field1 == decoded[2].field1);
	log(v[2].field2.get(0).unwrap() == decoded[2].field2.get(0).unwrap());
	log(v[2].field2.get(1).unwrap() == decoded[2].field2.get(1).unwrap());
	log(v[2].field2.get(2).unwrap() == decoded[2].field2.get(2).unwrap());
	log(v[3].field1 == decoded[3].field1);
	log(v[3].field2.get(0).unwrap() == decoded[3].field2.get(0).unwrap());
	log(v[3].field2.get(1).unwrap() == decoded[3].field2.get(1).unwrap());
	log(v[3].field2.get(2).unwrap() == decoded[3].field2.get(2).unwrap());
	log(v[3].field2.get(3).unwrap() == decoded[3].field2.get(3).unwrap());
	log(v[3].field2.get(4).unwrap() == decoded[3].field2.get(4).unwrap());
	let mut bytes51 = Bytes::new();
	bytes51.push(164u8);
	bytes51.push(132u8);
	bytes51.push(232u8);
	bytes51.push(88u8);
	bytes51.push(153u8);

	let raw_slice20 = bytes51.as_raw_slice();
    

    let v: raw_slice = raw_slice20;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<raw_slice>(encoded);
    log(Bytes::from(v) == Bytes::from(decoded));
    

    let v: u256 = 0x1029b09fb282caecc270107136128127f0a2d5a19670d8edbd94f888253bf04du256;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u256>(encoded);
    log(v == decoded);
    

    let v: u256 = 0x55127b1a6ad2d1cb0e0d3d690c4bac32fdca7898ecc6bc7e6a7fae0e38e46966u256;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u256>(encoded);
    log(v == decoded);
    

    let v: u32 = 2724003161;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u32>(encoded);
    log(v == decoded);
    

    let v: str[5] = __to_str_array("VZMC");
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<str[5]>(encoded);
    log(from_str_array(v) == from_str_array(decoded));
	let mut bytes52 = Bytes::new();
	bytes52.push(243u8);
	bytes52.push(38u8);

	let raw_slice21 = bytes52.as_raw_slice();

	let mut vector35 : Vec<Struct26> = Vec::new();
	vector35.push(Struct26 {field1 : Struct27 {field1 : 15057211015616359968,field2 : String::from_ascii_str("Kk*"),field3 : 0x8a25c499bd43c42346bf921e2f59164910188f33ce26a7b53196793187488591,field4 : 12312695935924243333,field5 : 204u8,},field2 : 174u8,field3 : Enum24::Variant2(4001443054),});
	vector35.push(Struct26 {field1 : Struct27 {field1 : 8857881472736434423,field2 : String::from_ascii_str("_/)5"),field3 : 0x53501f0b9658e8bfb12040339016e2a11ffe8f6477e5a5fedfe382f76156e769,field4 : 18233513476482879825,field5 : 221u8,},field2 : 233u8,field3 : Enum24::Variant1(raw_slice21),});
    

    let v: Vec<Struct26> = vector35;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Vec<Struct26>>(encoded);
    log(v.get(0).unwrap().field1.field1 == decoded.get(0).unwrap().field1.field1);
	log(v.get(0).unwrap().field1.field2 == decoded.get(0).unwrap().field1.field2);
	log(v.get(0).unwrap().field1.field3 == decoded.get(0).unwrap().field1.field3);
	log(v.get(0).unwrap().field1.field4 == decoded.get(0).unwrap().field1.field4);
	log(v.get(0).unwrap().field1.field5 == decoded.get(0).unwrap().field1.field5);
	log(v.get(0).unwrap().field2 == decoded.get(0).unwrap().field2);
	log(v.get(0).unwrap().field3.get_Variant2() == decoded.get(0).unwrap().field3.get_Variant2());
	log(v.get(1).unwrap().field1.field1 == decoded.get(1).unwrap().field1.field1);
	log(v.get(1).unwrap().field1.field2 == decoded.get(1).unwrap().field1.field2);
	log(v.get(1).unwrap().field1.field3 == decoded.get(1).unwrap().field1.field3);
	log(v.get(1).unwrap().field1.field4 == decoded.get(1).unwrap().field1.field4);
	log(v.get(1).unwrap().field1.field5 == decoded.get(1).unwrap().field1.field5);
	log(v.get(1).unwrap().field2 == decoded.get(1).unwrap().field2);
	log(Bytes::from(v.get(1).unwrap().field3.get_Variant1()) == Bytes::from(decoded.get(1).unwrap().field3.get_Variant1()));
	let mut bytes53 = Bytes::new();
	bytes53.push(217u8);
	bytes53.push(88u8);

	let raw_slice22 = bytes53.as_raw_slice();
    

    let v: raw_slice = raw_slice22;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<raw_slice>(encoded);
    log(Bytes::from(v) == Bytes::from(decoded));
	let mut bytes54 = Bytes::new();
	bytes54.push(101u8);
	bytes54.push(108u8);
	bytes54.push(39u8);

	let raw_slice23 = bytes54.as_raw_slice();
    

    let v: Enum25 = Enum25::Variant1(raw_slice23);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum25>(encoded);
    log(Bytes::from(v.get_Variant1()) == Bytes::from(decoded.get_Variant1()));
	let mut bytes55 = Bytes::new();
	bytes55.push(114u8);
	bytes55.push(124u8);

	let mut bytes56 = Bytes::new();
	bytes56.push(208u8);
	bytes56.push(61u8);
	bytes56.push(64u8);
	bytes56.push(124u8);
	bytes56.push(7u8);

	let mut vector36 : Vec<Bytes> = Vec::new();
	vector36.push(bytes55);
	vector36.push(bytes56);

	let mut bytes57 = Bytes::new();
	bytes57.push(45u8);
	bytes57.push(212u8);

	let mut bytes58 = Bytes::new();
	bytes58.push(116u8);
	bytes58.push(183u8);
	bytes58.push(56u8);
	bytes58.push(13u8);

	let mut bytes59 = Bytes::new();
	bytes59.push(81u8);

	let mut vector37 : Vec<Bytes> = Vec::new();
	vector37.push(bytes57);
	vector37.push(bytes58);
	vector37.push(bytes59);

	let mut bytes60 = Bytes::new();
	bytes60.push(229u8);
	bytes60.push(71u8);
	bytes60.push(164u8);

	let mut bytes61 = Bytes::new();
	bytes61.push(173u8);
	bytes61.push(105u8);
	bytes61.push(63u8);
	bytes61.push(149u8);

	let mut vector38 : Vec<Bytes> = Vec::new();
	vector38.push(bytes60);
	vector38.push(bytes61);

	let mut bytes62 = Bytes::new();
	bytes62.push(183u8);
	bytes62.push(121u8);

	let mut bytes63 = Bytes::new();
	bytes63.push(80u8);
	bytes63.push(117u8);
	bytes63.push(117u8);
	bytes63.push(242u8);
	bytes63.push(197u8);

	let mut bytes64 = Bytes::new();
	bytes64.push(248u8);

	let mut bytes65 = Bytes::new();
	bytes65.push(86u8);
	bytes65.push(247u8);
	bytes65.push(162u8);
	bytes65.push(250u8);
	bytes65.push(26u8);

	let mut bytes66 = Bytes::new();
	bytes66.push(132u8);
	bytes66.push(14u8);
	bytes66.push(193u8);

	let mut vector39 : Vec<Bytes> = Vec::new();
	vector39.push(bytes62);
	vector39.push(bytes63);
	vector39.push(bytes64);
	vector39.push(bytes65);
	vector39.push(bytes66);
    

    let v: [Vec<Bytes>; 4] = [vector36, vector37, vector38, vector39];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[Vec<Bytes>; 4]>(encoded);
    log(v[0].get(0).unwrap() == decoded[0].get(0).unwrap());
	log(v[0].get(1).unwrap() == decoded[0].get(1).unwrap());
	log(v[1].get(0).unwrap() == decoded[1].get(0).unwrap());
	log(v[1].get(1).unwrap() == decoded[1].get(1).unwrap());
	log(v[1].get(2).unwrap() == decoded[1].get(2).unwrap());
	log(v[2].get(0).unwrap() == decoded[2].get(0).unwrap());
	log(v[2].get(1).unwrap() == decoded[2].get(1).unwrap());
	log(v[3].get(0).unwrap() == decoded[3].get(0).unwrap());
	log(v[3].get(1).unwrap() == decoded[3].get(1).unwrap());
	log(v[3].get(2).unwrap() == decoded[3].get(2).unwrap());
	log(v[3].get(3).unwrap() == decoded[3].get(3).unwrap());
	log(v[3].get(4).unwrap() == decoded[3].get(4).unwrap());
    

    let v: Enum27 = Enum27::Variant1(false);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum27>(encoded);
    log(v.get_Variant1() == decoded.get_Variant1());
	let mut bytes67 = Bytes::new();
	bytes67.push(128u8);

	let mut bytes68 = Bytes::new();
	bytes68.push(203u8);
	bytes68.push(199u8);
	bytes68.push(98u8);
    

    let v: (Enum28, Bytes, [Struct31; 1], str[5]) = (Enum28::Variant1(Enum29::Variant1(0xdd5f1e80f20b5eafb4135de7359fa720e6761ac39b5f5aafa02b2dd44590b6d3u256)), bytes67, [Struct31 {field1 : bytes68,field2 : "y!",field3 : true,field4 : 60796,field5 : 2679612203,}], __to_str_array("}39"));
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<(Enum28, Bytes, [Struct31; 1], str[5])>(encoded);
    log(v.0.get_Variant1().get_Variant1() == decoded.0.get_Variant1().get_Variant1());
	log(v.1 == decoded.1);
	log(v.2[0].field1 == decoded.2[0].field1);
	log(v.2[0].field2 == decoded.2[0].field2);
	log(v.2[0].field3 == decoded.2[0].field3);
	log(v.2[0].field4 == decoded.2[0].field4);
	log(v.2[0].field5 == decoded.2[0].field5);
	log(from_str_array(v.3) == from_str_array(decoded.3));
    

    let v: u64 = 2466750645745043313;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u64>(encoded);
    log(v == decoded);
    

    let v: u16 = 40346;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u16>(encoded);
    log(v == decoded);
    

    let v: Enum31 = Enum31::Variant1(0x8b4bc390478cac76c65b7433a9eba97903dc97588988838abaef97c727cbb1c9);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum31>(encoded);
    log(v.get_Variant1() == decoded.get_Variant1());
    

    let v: Enum32 = Enum32::Variant2(0xfb71f9a685385d72134829cafbeceff6d251898f63a326cdee911217daf7359u256);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum32>(encoded);
    log(v.get_Variant2() == decoded.get_Variant2());
	let mut bytes69 = Bytes::new();
	bytes69.push(205u8);

	let raw_slice24 = bytes69.as_raw_slice();
    

    let v: Enum33 = Enum33::Variant1(raw_slice24);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum33>(encoded);
    log(Bytes::from(v.get_Variant1()) == Bytes::from(decoded.get_Variant1()));
    

    let v: str[3] = __to_str_array("0g");
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<str[3]>(encoded);
    log(from_str_array(v) == from_str_array(decoded));
	let mut bytes70 = Bytes::new();
	bytes70.push(253u8);
	bytes70.push(18u8);

	let raw_slice25 = bytes70.as_raw_slice();
    

    let v: raw_slice = raw_slice25;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<raw_slice>(encoded);
    log(Bytes::from(v) == Bytes::from(decoded));
    

    let v: String = String::from_ascii_str("i*");
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<String>(encoded);
    log(v == decoded);
	let mut vector40 : Vec<String> = Vec::new();
	vector40.push(String::from_ascii_str("w"));

	let mut vector41 : Vec<String> = Vec::new();
	vector41.push(String::from_ascii_str("*z"));
	vector41.push(String::from_ascii_str("R6~"));
	vector41.push(String::from_ascii_str("M*H,"));
	vector41.push(String::from_ascii_str("nd"));
	vector41.push(String::from_ascii_str("3"));
    

    let v: [[Vec<String>; 2]; 1] = [[vector40, vector41]];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[[Vec<String>; 2]; 1]>(encoded);
    log(v[0][0].get(0).unwrap() == decoded[0][0].get(0).unwrap());
	log(v[0][1].get(0).unwrap() == decoded[0][1].get(0).unwrap());
	log(v[0][1].get(1).unwrap() == decoded[0][1].get(1).unwrap());
	log(v[0][1].get(2).unwrap() == decoded[0][1].get(2).unwrap());
	log(v[0][1].get(3).unwrap() == decoded[0][1].get(3).unwrap());
	log(v[0][1].get(4).unwrap() == decoded[0][1].get(4).unwrap());
    

    let v: u32 = 2354733306;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u32>(encoded);
    log(v == decoded);
	let mut bytes71 = Bytes::new();
	bytes71.push(234u8);
    

    let v: Bytes = bytes71;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Bytes>(encoded);
    log(v == decoded);
	let mut vector42 : Vec<u32> = Vec::new();
	vector42.push(1390615605);
	vector42.push(4202216799);
	vector42.push(518451165);
	vector42.push(3522008674);

	let mut bytes72 = Bytes::new();
	bytes72.push(192u8);

	let raw_slice26 = bytes72.as_raw_slice();
    

    let v: Struct32 = Struct32 {field1 : vector42,field2 : 0xb94d945409ed1a77669731dba523bef353c13d827bcc7939675cc4a7ccc09aebu256,field3 : Enum34::Variant2(String::from_ascii_str("<n5")),field4 : ((0x5df4bba20ab095f1782716616e8767d35b68d8f913462b71bab6f6e6d7d89d83u256, "cBS$", "<", 0x1e8aa78ace9bdedbb02263aed8e7ff2cb1f1160de2b95b173a08ca69f6803ac1, String::from_ascii_str("{Z")), [String::from_ascii_str("XU1<"), String::from_ascii_str("G,4M")]),field5 : raw_slice26,};
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Struct32>(encoded);
    log(v.field1.get(0).unwrap() == decoded.field1.get(0).unwrap());
	log(v.field1.get(1).unwrap() == decoded.field1.get(1).unwrap());
	log(v.field1.get(2).unwrap() == decoded.field1.get(2).unwrap());
	log(v.field1.get(3).unwrap() == decoded.field1.get(3).unwrap());
	log(v.field2 == decoded.field2);
	log(v.field3.get_Variant2() == decoded.field3.get_Variant2());
	log(v.field4.0.0 == decoded.field4.0.0);
	log(v.field4.0.1 == decoded.field4.0.1);
	log(v.field4.0.2 == decoded.field4.0.2);
	log(v.field4.0.3 == decoded.field4.0.3);
	log(v.field4.0.4 == decoded.field4.0.4);
	log(v.field4.1[0] == decoded.field4.1[0]);
	log(v.field4.1[1] == decoded.field4.1[1]);
	log(Bytes::from(v.field5) == Bytes::from(decoded.field5));
    

    let v: Enum35 = Enum35::Variant1(0x34c792df8ab763da1efe067c4b11bbb72385301a4de73021772c82555641b5c0u256);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum35>(encoded);
    log(v.get_Variant1() == decoded.get_Variant1());
    

    let v: u32 = 1772667445;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u32>(encoded);
    log(v == decoded);
	let mut vector44 : Vec<str> = Vec::new();
	vector44.push("[");
	vector44.push("k");

	let mut vector45 : Vec<str> = Vec::new();
	vector45.push("Nen");
	vector45.push("~");
	vector45.push("LGp*");
	vector45.push("(");
	vector45.push("rGc");

	let mut vector46 : Vec<str> = Vec::new();
	vector46.push(" ");
	vector46.push(",");

	let mut vector47 : Vec<str> = Vec::new();
	vector47.push("9Q{*");
	vector47.push(" S*");

	let mut vector48 : Vec<str> = Vec::new();
	vector48.push("IxS");
	vector48.push("]");
	vector48.push("vgC");

	let mut vector49 : Vec<str> = Vec::new();
	vector49.push("M");

	let mut vector50 : Vec<str> = Vec::new();
	vector50.push("*O*z");
	vector50.push("|");
	vector50.push("[_nV");
	vector50.push("WIN[");

	let mut vector51 : Vec<str> = Vec::new();
	vector51.push("fW^");
	vector51.push("I gt");
	vector51.push("h~4");
	vector51.push("tC");

	let mut vector52 : Vec<str> = Vec::new();
	vector52.push("6N");
	vector52.push("0");
	vector52.push("QiD");

	let mut vector53 : Vec<str> = Vec::new();
	vector53.push("%");

	let mut vector43 : Vec<[Vec<str>; 2]> = Vec::new();
	vector43.push([vector44, vector45]);
	vector43.push([vector46, vector47]);
	vector43.push([vector48, vector49]);
	vector43.push([vector50, vector51]);
	vector43.push([vector52, vector53]);
    

    let v: Vec<[Vec<str>; 2]> = vector43;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Vec<[Vec<str>; 2]>>(encoded);
    log(v.get(0).unwrap()[0].get(0).unwrap() == decoded.get(0).unwrap()[0].get(0).unwrap());
	log(v.get(0).unwrap()[0].get(1).unwrap() == decoded.get(0).unwrap()[0].get(1).unwrap());
	log(v.get(0).unwrap()[1].get(0).unwrap() == decoded.get(0).unwrap()[1].get(0).unwrap());
	log(v.get(0).unwrap()[1].get(1).unwrap() == decoded.get(0).unwrap()[1].get(1).unwrap());
	log(v.get(0).unwrap()[1].get(2).unwrap() == decoded.get(0).unwrap()[1].get(2).unwrap());
	log(v.get(0).unwrap()[1].get(3).unwrap() == decoded.get(0).unwrap()[1].get(3).unwrap());
	log(v.get(0).unwrap()[1].get(4).unwrap() == decoded.get(0).unwrap()[1].get(4).unwrap());
	log(v.get(1).unwrap()[0].get(0).unwrap() == decoded.get(1).unwrap()[0].get(0).unwrap());
	log(v.get(1).unwrap()[0].get(1).unwrap() == decoded.get(1).unwrap()[0].get(1).unwrap());
	log(v.get(1).unwrap()[1].get(0).unwrap() == decoded.get(1).unwrap()[1].get(0).unwrap());
	log(v.get(1).unwrap()[1].get(1).unwrap() == decoded.get(1).unwrap()[1].get(1).unwrap());
	log(v.get(2).unwrap()[0].get(0).unwrap() == decoded.get(2).unwrap()[0].get(0).unwrap());
	log(v.get(2).unwrap()[0].get(1).unwrap() == decoded.get(2).unwrap()[0].get(1).unwrap());
	log(v.get(2).unwrap()[0].get(2).unwrap() == decoded.get(2).unwrap()[0].get(2).unwrap());
	log(v.get(2).unwrap()[1].get(0).unwrap() == decoded.get(2).unwrap()[1].get(0).unwrap());
	log(v.get(3).unwrap()[0].get(0).unwrap() == decoded.get(3).unwrap()[0].get(0).unwrap());
	log(v.get(3).unwrap()[0].get(1).unwrap() == decoded.get(3).unwrap()[0].get(1).unwrap());
	log(v.get(3).unwrap()[0].get(2).unwrap() == decoded.get(3).unwrap()[0].get(2).unwrap());
	log(v.get(3).unwrap()[0].get(3).unwrap() == decoded.get(3).unwrap()[0].get(3).unwrap());
	log(v.get(3).unwrap()[1].get(0).unwrap() == decoded.get(3).unwrap()[1].get(0).unwrap());
	log(v.get(3).unwrap()[1].get(1).unwrap() == decoded.get(3).unwrap()[1].get(1).unwrap());
	log(v.get(3).unwrap()[1].get(2).unwrap() == decoded.get(3).unwrap()[1].get(2).unwrap());
	log(v.get(3).unwrap()[1].get(3).unwrap() == decoded.get(3).unwrap()[1].get(3).unwrap());
	log(v.get(4).unwrap()[0].get(0).unwrap() == decoded.get(4).unwrap()[0].get(0).unwrap());
	log(v.get(4).unwrap()[0].get(1).unwrap() == decoded.get(4).unwrap()[0].get(1).unwrap());
	log(v.get(4).unwrap()[0].get(2).unwrap() == decoded.get(4).unwrap()[0].get(2).unwrap());
	log(v.get(4).unwrap()[1].get(0).unwrap() == decoded.get(4).unwrap()[1].get(0).unwrap());
    

    let v: str[2] = __to_str_array("Ty");
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<str[2]>(encoded);
    log(from_str_array(v) == from_str_array(decoded));
	let mut vector55 : Vec<u256> = Vec::new();
	vector55.push(0x3ba492efc2f58483dcea596df72f4d6ed3c1106928ab7daeb523bb35bf4d5a32u256);
	vector55.push(0xbca7258d5df58615a9abea58fc034fb44221e9a5396978e6f21b3979be1e8b5cu256);
	vector55.push(0x339d6d1ed5b5fd96955468d654e3c48a18995883a18676f7ff231eee52e27e4au256);
	vector55.push(0x23717a8c8b0c8051857295e5cdc072ae0c9fa9068707c708feef951d8dd2a708u256);
	vector55.push(0x93c9037a585541f6c3ce41c8433e525876dba0382ba1e91a59be8a5de9aa805au256);

	let mut vector56 : Vec<u256> = Vec::new();
	vector56.push(0x14fe1ed921f8ad2a20ccd61ca47b2c1d661bdaaadba92d37ed7fa9cfbb10fef7u256);
	vector56.push(0x604c0a4947e7a59cc5ef41c12262cdc81291b06c92dfc11e8dc82e578fe802c5u256);

	let mut vector54 : Vec<Vec<u256>> = Vec::new();
	vector54.push(vector55);
	vector54.push(vector56);
    

    let v: Vec<Vec<u256>> = vector54;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Vec<Vec<u256>>>(encoded);
    log(v.get(0).unwrap().get(0).unwrap() == decoded.get(0).unwrap().get(0).unwrap());
	log(v.get(0).unwrap().get(1).unwrap() == decoded.get(0).unwrap().get(1).unwrap());
	log(v.get(0).unwrap().get(2).unwrap() == decoded.get(0).unwrap().get(2).unwrap());
	log(v.get(0).unwrap().get(3).unwrap() == decoded.get(0).unwrap().get(3).unwrap());
	log(v.get(0).unwrap().get(4).unwrap() == decoded.get(0).unwrap().get(4).unwrap());
	log(v.get(1).unwrap().get(0).unwrap() == decoded.get(1).unwrap().get(0).unwrap());
	log(v.get(1).unwrap().get(1).unwrap() == decoded.get(1).unwrap().get(1).unwrap());
    

    let v: str[1] = __to_str_array(" ");
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<str[1]>(encoded);
    log(from_str_array(v) == from_str_array(decoded));
    

    let v: [str[3]; 5] = [__to_str_array("h;-"), __to_str_array("tpM"), __to_str_array("o~"), __to_str_array("a*"), __to_str_array("*OD")];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[str[3]; 5]>(encoded);
    log(from_str_array(v[0]) == from_str_array(decoded[0]));
	log(from_str_array(v[1]) == from_str_array(decoded[1]));
	log(from_str_array(v[2]) == from_str_array(decoded[2]));
	log(from_str_array(v[3]) == from_str_array(decoded[3]));
	log(from_str_array(v[4]) == from_str_array(decoded[4]));
    

    let v: u64 = 9864602552847204304;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u64>(encoded);
    log(v == decoded);
	let mut vector57 : Vec<Struct33> = Vec::new();
	vector57.push(Struct33 {field1 : true,field2 : String::from_ascii_str("C"),field3 : 8290,field4 : 976,});
	vector57.push(Struct33 {field1 : false,field2 : String::from_ascii_str("{L"),field3 : 665,field4 : 23343,});
	vector57.push(Struct33 {field1 : true,field2 : String::from_ascii_str(""),field3 : 20430,field4 : 55745,});
	vector57.push(Struct33 {field1 : true,field2 : String::from_ascii_str("L"),field3 : 27853,field4 : 36593,});
	vector57.push(Struct33 {field1 : true,field2 : String::from_ascii_str("]"),field3 : 19435,field4 : 28772,});

	let mut vector58 : Vec<String> = Vec::new();
	vector58.push(String::from_ascii_str(">0"));
    

    let v: (bool, Vec<Struct33>, str[2], String, Vec<String>) = (true, vector57, __to_str_array("uQ"), String::from_ascii_str("O_1C["), vector58);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<(bool, Vec<Struct33>, str[2], String, Vec<String>)>(encoded);
    log(v.0 == decoded.0);
	log(v.1.get(0).unwrap().field1 == decoded.1.get(0).unwrap().field1);
	log(v.1.get(0).unwrap().field2 == decoded.1.get(0).unwrap().field2);
	log(v.1.get(0).unwrap().field3 == decoded.1.get(0).unwrap().field3);
	log(v.1.get(0).unwrap().field4 == decoded.1.get(0).unwrap().field4);
	log(v.1.get(1).unwrap().field1 == decoded.1.get(1).unwrap().field1);
	log(v.1.get(1).unwrap().field2 == decoded.1.get(1).unwrap().field2);
	log(v.1.get(1).unwrap().field3 == decoded.1.get(1).unwrap().field3);
	log(v.1.get(1).unwrap().field4 == decoded.1.get(1).unwrap().field4);
	log(v.1.get(2).unwrap().field1 == decoded.1.get(2).unwrap().field1);
	log(v.1.get(2).unwrap().field2 == decoded.1.get(2).unwrap().field2);
	log(v.1.get(2).unwrap().field3 == decoded.1.get(2).unwrap().field3);
	log(v.1.get(2).unwrap().field4 == decoded.1.get(2).unwrap().field4);
	log(v.1.get(3).unwrap().field1 == decoded.1.get(3).unwrap().field1);
	log(v.1.get(3).unwrap().field2 == decoded.1.get(3).unwrap().field2);
	log(v.1.get(3).unwrap().field3 == decoded.1.get(3).unwrap().field3);
	log(v.1.get(3).unwrap().field4 == decoded.1.get(3).unwrap().field4);
	log(v.1.get(4).unwrap().field1 == decoded.1.get(4).unwrap().field1);
	log(v.1.get(4).unwrap().field2 == decoded.1.get(4).unwrap().field2);
	log(v.1.get(4).unwrap().field3 == decoded.1.get(4).unwrap().field3);
	log(v.1.get(4).unwrap().field4 == decoded.1.get(4).unwrap().field4);
	log(from_str_array(v.2) == from_str_array(decoded.2));
	log(v.3 == decoded.3);
	log(v.4.get(0).unwrap() == decoded.4.get(0).unwrap());
    

    let v: Enum37 = Enum37::Variant1(Struct34 {field1 : 0x101ddd6d0937d19d443b5c2a5d074f559e602a89160ea158135b06f62d412212,field2 : Enum38::Variant1(0x9e8907d5dd4047beb89900ee7f0eb5f9f22ed4f353a2495380c32daa7ce8ccccu256),field3 : false,field4 : 168u8,field5 : (4793, 163u8, true),});
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum37>(encoded);
    log(v.get_Variant1().field1 == decoded.get_Variant1().field1);
	log(v.get_Variant1().field2.get_Variant1() == decoded.get_Variant1().field2.get_Variant1());
	log(v.get_Variant1().field3 == decoded.get_Variant1().field3);
	log(v.get_Variant1().field4 == decoded.get_Variant1().field4);
	log(v.get_Variant1().field5.0 == decoded.get_Variant1().field5.0);
	log(v.get_Variant1().field5.1 == decoded.get_Variant1().field5.1);
	log(v.get_Variant1().field5.2 == decoded.get_Variant1().field5.2);
	let mut vector59 : Vec<u32> = Vec::new();
	vector59.push(503950060);
	vector59.push(2525791925);
	vector59.push(1755985022);
	vector59.push(972372074);

	let mut vector60 : Vec<u32> = Vec::new();
	vector60.push(3305004434);
	vector60.push(1187418699);
	vector60.push(3430635591);
	vector60.push(3828083607);
    

    let v: Enum39 = Enum39::Variant1([vector59, vector60]);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Enum39>(encoded);
    log(v.get_Variant1()[0].get(0).unwrap() == decoded.get_Variant1()[0].get(0).unwrap());
	log(v.get_Variant1()[0].get(1).unwrap() == decoded.get_Variant1()[0].get(1).unwrap());
	log(v.get_Variant1()[0].get(2).unwrap() == decoded.get_Variant1()[0].get(2).unwrap());
	log(v.get_Variant1()[0].get(3).unwrap() == decoded.get_Variant1()[0].get(3).unwrap());
	log(v.get_Variant1()[1].get(0).unwrap() == decoded.get_Variant1()[1].get(0).unwrap());
	log(v.get_Variant1()[1].get(1).unwrap() == decoded.get_Variant1()[1].get(1).unwrap());
	log(v.get_Variant1()[1].get(2).unwrap() == decoded.get_Variant1()[1].get(2).unwrap());
	log(v.get_Variant1()[1].get(3).unwrap() == decoded.get_Variant1()[1].get(3).unwrap());
    

    let v: u16 = 57491;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u16>(encoded);
    log(v == decoded);
    

    let v: u32 = 131296768;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u32>(encoded);
    log(v == decoded);
    

    let v: u16 = 64508;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u16>(encoded);
    log(v == decoded);
    

    let v: Struct35 = Struct35 {field1 : 0x1f77dfd88cce9e582acf68b6db6845269412e1ac45c078c03014b336c2a322cf,field2 : Struct36 {field1 : 231u8,field2 : 0x8b6c8f248b4f2c6b8d490b5d72fa0fd8ec8da503d8cbec9ec9a09eff5fffabd5u256,field3 : 7178385899581212431,field4 : Struct37 {field1 : "",field2 : 0xaf4494644fdb5b1aeda651a444318278ffe4f62f8933530d05116b3a1bbe726u256,field3 : "N6 ",field4 : 11733466527255627442,},},field3 : 0xe55a9f1917d661e066e112dc9a1b8b162480506ef3992361856527297bb0ce79u256,};
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Struct35>(encoded);
    log(v.field1 == decoded.field1);
	log(v.field2.field1 == decoded.field2.field1);
	log(v.field2.field2 == decoded.field2.field2);
	log(v.field2.field3 == decoded.field2.field3);
	log(v.field2.field4.field1 == decoded.field2.field4.field1);
	log(v.field2.field4.field2 == decoded.field2.field4.field2);
	log(v.field2.field4.field3 == decoded.field2.field4.field3);
	log(v.field2.field4.field4 == decoded.field2.field4.field4);
	log(v.field3 == decoded.field3);
	let mut vector61 : Vec<[u32; 5]> = Vec::new();
	vector61.push([1085083342, 1453046044, 679732900, 514467690, 1423853561]);
	vector61.push([2703735045, 4075763857, 2139925112, 2280375337, 1955182082]);
	vector61.push([2497101478, 1876915002, 555859757, 305617703, 926682815]);
	vector61.push([1875147795, 2239079747, 1496465005, 2311180694, 3715720698]);
    

    let v: Vec<[u32; 5]> = vector61;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Vec<[u32; 5]>>(encoded);
    log(v.get(0).unwrap()[0] == decoded.get(0).unwrap()[0]);
	log(v.get(0).unwrap()[1] == decoded.get(0).unwrap()[1]);
	log(v.get(0).unwrap()[2] == decoded.get(0).unwrap()[2]);
	log(v.get(0).unwrap()[3] == decoded.get(0).unwrap()[3]);
	log(v.get(0).unwrap()[4] == decoded.get(0).unwrap()[4]);
	log(v.get(1).unwrap()[0] == decoded.get(1).unwrap()[0]);
	log(v.get(1).unwrap()[1] == decoded.get(1).unwrap()[1]);
	log(v.get(1).unwrap()[2] == decoded.get(1).unwrap()[2]);
	log(v.get(1).unwrap()[3] == decoded.get(1).unwrap()[3]);
	log(v.get(1).unwrap()[4] == decoded.get(1).unwrap()[4]);
	log(v.get(2).unwrap()[0] == decoded.get(2).unwrap()[0]);
	log(v.get(2).unwrap()[1] == decoded.get(2).unwrap()[1]);
	log(v.get(2).unwrap()[2] == decoded.get(2).unwrap()[2]);
	log(v.get(2).unwrap()[3] == decoded.get(2).unwrap()[3]);
	log(v.get(2).unwrap()[4] == decoded.get(2).unwrap()[4]);
	log(v.get(3).unwrap()[0] == decoded.get(3).unwrap()[0]);
	log(v.get(3).unwrap()[1] == decoded.get(3).unwrap()[1]);
	log(v.get(3).unwrap()[2] == decoded.get(3).unwrap()[2]);
	log(v.get(3).unwrap()[3] == decoded.get(3).unwrap()[3]);
	log(v.get(3).unwrap()[4] == decoded.get(3).unwrap()[4]);

  
return
}
