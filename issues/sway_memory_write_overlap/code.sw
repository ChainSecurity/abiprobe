script;

use std::vec::Vec;
use std::address::Address;
use core::codec::*;
use core::codec::Buffer;
use std::bytes::Bytes;
use std::string::String;

enum Enum238 {
	Variant1 : str,
	Variant2 : u16,
}

impl Enum238 {
    fn get_Variant1(self) -> str {
        match self {
            Enum238::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> u16 {
        match self {
            Enum238::Variant2(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct246 {
	field1 : [u256; 5],
	field2 : [u32; 2],
	field3 : str,
	field4 : Enum238,
}
enum Enum239 {
	Variant1 : u8,
	Variant2 : Vec<[u64; 5]>,
	Variant3 : Vec<bool>,
}

impl Enum239 {
    fn get_Variant1(self) -> u8 {
        match self {
            Enum239::Variant1(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant2(self) -> Vec<[u64; 5]> {
        match self {
            Enum239::Variant2(v) => v,
            _ => revert(0),
        }
    }
fn get_Variant3(self) -> Vec<bool> {
        match self {
            Enum239::Variant3(v) => v,
            _ => revert(0),
        }
    }
}

fn main() -> () {

    

    let v: b256 = 0xba73a95cee8440093f96ee041ee69651da51376084ef27d3dbdd5c94027a378e;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<b256>(encoded);
    log(v == decoded);
	let mut bytes0 = Bytes::new();
	bytes0.push(108u8);

	let raw_slice0 = bytes0.as_raw_slice();

	let mut vector0 : Vec<[u8; 1]> = Vec::new();
	vector0.push([50u8]);
	vector0.push([54u8]);
	vector0.push([106u8]);

	let mut vector1 : Vec<[Struct246; 3]> = Vec::new();
	vector1.push([Struct246 {field1 : [0xc67979463d03554cd59654b8d20a302701ac7d84fab852afa344a7a674162162u256, 0x2e4af09a119ca3476461e3a109ab140cf23575a957bf4ff75c67d31e1809f59du256, 0xcbfbf0d3a8182ae1180563b0e5674ff7994fdae678c7c55bf7642bd9dd08677u256, 0x33d14bf8848c46679daa8086a739cc6fdf2b221886b0ec72174c0a886d2ed559u256, 0xe094746b8ef4c3e529d6f5b25eb48316810739f4d673260ceb6ad60fe7a0fdc3u256],field2 : [1880557382, 2108859172],field3 : "Y",field4 : Enum238::Variant1("T2"),}, Struct246 {field1 : [0x829833433d74de6deb8b15452844b75efb894f7bd0ae035af4a5558b4c98ea2bu256, 0xb5bccb302e6c29b79a1e617fc8d2d3e0a99154fd508b4b5f0363c8a1fbe4197eu256, 0x1bb9f4c5bf01aa1c6323795e07ab6e6e43f90ec86cb25383fbddbedc2f4e1d5cu256, 0xd83bbc16c76e371b448884c484e46ce72bfec68ab1ff181b50dc9b8bfac29797u256, 0x3977bca4eafa88f866bbc7f58c60c1b3efbfff0cb1cd788961e5539230439408u256],field2 : [2589372995, 3481115919],field3 : "hx",field4 : Enum238::Variant1("$"),}, Struct246 {field1 : [0x916423dffcbebc9ce3f11553b907efb714a47d6a8890b5c06b3c2f85834bea4eu256, 0xcf62028be95cc7c38c0f67e55f1dd193ce1e0bccafd6930ea09015a72927b63u256, 0x40301129c7ed66e0ac1a72054504e29beb6d8958c5374391cd4effda9b15ec39u256, 0x4eaf1fc0d4732f5bd033b71170fedf7bd389b02b2445dac532de658d88498a45u256, 0x636fddc1ed352ce0896028a23350521e47d11b3193dc1829ea568dc8a194a195u256],field2 : [2504278768, 803628877],field3 : "Hq!@",field4 : Enum238::Variant2(48802),}]);
	vector1.push([Struct246 {field1 : [0x7aa5bcfbbcfb1717ba10a08cc40b2ec71994af0a7b6e479698b280d185ccd43u256, 0x47c190aaf176d86b5bc54931dae040df2ab46b5ab68ce1aee6af938fe5aab795u256, 0xb90c89ab708bbfd4dfe794082207491db9c1f2e96a90c86ddb1dfa22d7967959u256, 0xb5914a0e0a2451b5733c428e6b1ebbb55e90987d7554fa211bb1838dd7c8520cu256, 0x8fd8c8be49dd3975416d68ee63784311599d2d619c273e2b56e14f864903047cu256],field2 : [1269986932, 1170880385],field3 : "mo/",field4 : Enum238::Variant2(44429),}, Struct246 {field1 : [0x4c29247835d76b6ba736f852c93c3fd7b01250d3c47f7e2375420047109b8f9au256, 0x6fc36b91f80e02dfa28c21393304554038ef4999e89df97ad5bc4155120aba0du256, 0x59188b664267fd11ee3960d18c5485aab0da2b2dd47e1e1a31ebe03fc8fdaf9du256, 0xc982c5bf67feed8b7d85463b81175b3cecb6a9db9ef7c842d92cf5bc294257bu256, 0x4110359f0dce2079aa7ebdeeffe9cbc35160794cb3e4ea9ef47470a1cc7df97cu256],field2 : [1165965390, 308981007],field3 : "Gy4",field4 : Enum238::Variant2(38662),}, Struct246 {field1 : [0x46074d217670b9062b0e7e46b6c9dad3940f205162c87e8b16c136c70fd72ff1u256, 0x66dc9c97ccdb44d9d9460feadc3fb722680d91a236c91ca2b07d9d8822baf90du256, 0x799c2807b39c3760c056f7281898fa2a7c3257558e06b07c317ae25c085655fau256, 0x5aa83b23a3bf688064cf2bf521978b929c67e5b5a3ef38ff8e71022486e94233u256, 0x1d6eea99aadb4975d37c97ab25a454c47967f46d3a95c117c0e07a426505b7e2u256],field2 : [2825540785, 2726963937],field3 : "{xZ",field4 : Enum238::Variant1("C0J"),}]);
	vector1.push([Struct246 {field1 : [0x7b575e8e811d02d129ce578ec4bdbcc6144d06601dc018d432a5da95d90fd35au256, 0x293e3d0d6a1590f46544c7713f0ff4ba6bd2860adf059256fd1ad8449e635938u256, 0xe796e4b58780b12ae325b027afaf0fe1cb78dade29e7733fb1f03877a5e7a29eu256, 0x49dfec97683ec4e70051ac58283222c032892ea29e4b670627c003b4a45b5602u256, 0x48f99be967918ac68a6b4532146ceda5d129fbf2ed6aeb12e68b5fbacee134c7u256],field2 : [1990267795, 1522867282],field3 : "*",field4 : Enum238::Variant1(""),}, Struct246 {field1 : [0x70849d52f6f4643a792452487af6c697e88c62e549d9d8e63e92a363a5c2c9cbu256, 0xdcd8540c496916e6ab4f8f4a9487ee1991ed4c2e57731a2ef9a3006059a9dfc5u256, 0xa179fc60207d25819264612ec7593a183fd4a72030f389e81d9a381666e0e034u256, 0x4cabc2279d1511b878d99135c23940f48473a702edc5f370261802076a2e4c00u256, 0xc44276a52d54631f36f651dd917a52f1e094e181f7163e0a48290b0c100e57dfu256],field2 : [2102565040, 2598206006],field3 : "V*dl",field4 : Enum238::Variant1("=l"),}, Struct246 {field1 : [0x18771ae33db93f72e45075f561421d7a5c2378e2c738e10225eb45283630db9au256, 0xb94ac04e645081f1810f93a91c4b5a992424a82bb3255eb61d0261c3bbd9fa18u256, 0xcecd2f140716d85dee4043a125b2a8500a390342718616c47b481fd86da74f0eu256, 0xb34094eb6eeb8693f1ff8f9a3efb02e55af5aa0c126e6d39cab6c70f64498c58u256, 0x1c114188d4526aacb1f7e025cbc2689302dcd1935f4a53fafd9b58b34f47f13cu256],field2 : [1811019702, 84150704],field3 : "u",field4 : Enum238::Variant1("%"),}]);
    

    let v: (raw_slice, Vec<[u8; 1]>, Vec<[Struct246; 3]>) = (raw_slice0, vector0, vector1);
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<(raw_slice, Vec<[u8; 1]>, Vec<[Struct246; 3]>)>(encoded);
    log(Bytes::from(v.0) == Bytes::from(decoded.0));
	log(v.1.get(0).unwrap()[0] == decoded.1.get(0).unwrap()[0]);
	log(v.1.get(1).unwrap()[0] == decoded.1.get(1).unwrap()[0]);
	log(v.1.get(2).unwrap()[0] == decoded.1.get(2).unwrap()[0]);
	log(v.2.get(0).unwrap()[0].field1[0] == decoded.2.get(0).unwrap()[0].field1[0]);
	log(v.2.get(0).unwrap()[0].field1[1] == decoded.2.get(0).unwrap()[0].field1[1]);
	log(v.2.get(0).unwrap()[0].field1[2] == decoded.2.get(0).unwrap()[0].field1[2]);
	log(v.2.get(0).unwrap()[0].field1[3] == decoded.2.get(0).unwrap()[0].field1[3]);
	log(v.2.get(0).unwrap()[0].field1[4] == decoded.2.get(0).unwrap()[0].field1[4]);
	log(v.2.get(0).unwrap()[0].field2[0] == decoded.2.get(0).unwrap()[0].field2[0]);
	log(v.2.get(0).unwrap()[0].field2[1] == decoded.2.get(0).unwrap()[0].field2[1]);
	log(v.2.get(0).unwrap()[0].field3 == decoded.2.get(0).unwrap()[0].field3);
	log(v.2.get(0).unwrap()[0].field4.get_Variant1() == decoded.2.get(0).unwrap()[0].field4.get_Variant1());
	log(v.2.get(0).unwrap()[1].field1[0] == decoded.2.get(0).unwrap()[1].field1[0]);
	log(v.2.get(0).unwrap()[1].field1[1] == decoded.2.get(0).unwrap()[1].field1[1]);
	log(v.2.get(0).unwrap()[1].field1[2] == decoded.2.get(0).unwrap()[1].field1[2]);
	log(v.2.get(0).unwrap()[1].field1[3] == decoded.2.get(0).unwrap()[1].field1[3]);
	log(v.2.get(0).unwrap()[1].field1[4] == decoded.2.get(0).unwrap()[1].field1[4]);
	log(v.2.get(0).unwrap()[1].field2[0] == decoded.2.get(0).unwrap()[1].field2[0]);
	log(v.2.get(0).unwrap()[1].field2[1] == decoded.2.get(0).unwrap()[1].field2[1]);
	log(v.2.get(0).unwrap()[1].field3 == decoded.2.get(0).unwrap()[1].field3);
	log(v.2.get(0).unwrap()[1].field4.get_Variant1() == decoded.2.get(0).unwrap()[1].field4.get_Variant1());
	log(v.2.get(0).unwrap()[2].field1[0] == decoded.2.get(0).unwrap()[2].field1[0]);
	log(v.2.get(0).unwrap()[2].field1[1] == decoded.2.get(0).unwrap()[2].field1[1]);
	log(v.2.get(0).unwrap()[2].field1[2] == decoded.2.get(0).unwrap()[2].field1[2]);
	log(v.2.get(0).unwrap()[2].field1[3] == decoded.2.get(0).unwrap()[2].field1[3]);
	log(v.2.get(0).unwrap()[2].field1[4] == decoded.2.get(0).unwrap()[2].field1[4]);
	log(v.2.get(0).unwrap()[2].field2[0] == decoded.2.get(0).unwrap()[2].field2[0]);
	log(v.2.get(0).unwrap()[2].field2[1] == decoded.2.get(0).unwrap()[2].field2[1]);
	log(v.2.get(0).unwrap()[2].field3 == decoded.2.get(0).unwrap()[2].field3);
	log(v.2.get(0).unwrap()[2].field4.get_Variant2() == decoded.2.get(0).unwrap()[2].field4.get_Variant2());
	log(v.2.get(1).unwrap()[0].field1[0] == decoded.2.get(1).unwrap()[0].field1[0]);
	log(v.2.get(1).unwrap()[0].field1[1] == decoded.2.get(1).unwrap()[0].field1[1]);
	log(v.2.get(1).unwrap()[0].field1[2] == decoded.2.get(1).unwrap()[0].field1[2]);
	log(v.2.get(1).unwrap()[0].field1[3] == decoded.2.get(1).unwrap()[0].field1[3]);
	log(v.2.get(1).unwrap()[0].field1[4] == decoded.2.get(1).unwrap()[0].field1[4]);
	log(v.2.get(1).unwrap()[0].field2[0] == decoded.2.get(1).unwrap()[0].field2[0]);
	log(v.2.get(1).unwrap()[0].field2[1] == decoded.2.get(1).unwrap()[0].field2[1]);
	log(v.2.get(1).unwrap()[0].field3 == decoded.2.get(1).unwrap()[0].field3);
	log(v.2.get(1).unwrap()[0].field4.get_Variant2() == decoded.2.get(1).unwrap()[0].field4.get_Variant2());
	log(v.2.get(1).unwrap()[1].field1[0] == decoded.2.get(1).unwrap()[1].field1[0]);
	log(v.2.get(1).unwrap()[1].field1[1] == decoded.2.get(1).unwrap()[1].field1[1]);
	log(v.2.get(1).unwrap()[1].field1[2] == decoded.2.get(1).unwrap()[1].field1[2]);
	log(v.2.get(1).unwrap()[1].field1[3] == decoded.2.get(1).unwrap()[1].field1[3]);
	log(v.2.get(1).unwrap()[1].field1[4] == decoded.2.get(1).unwrap()[1].field1[4]);
	log(v.2.get(1).unwrap()[1].field2[0] == decoded.2.get(1).unwrap()[1].field2[0]);
	log(v.2.get(1).unwrap()[1].field2[1] == decoded.2.get(1).unwrap()[1].field2[1]);
	log(v.2.get(1).unwrap()[1].field3 == decoded.2.get(1).unwrap()[1].field3);
	log(v.2.get(1).unwrap()[1].field4.get_Variant2() == decoded.2.get(1).unwrap()[1].field4.get_Variant2());
	log(v.2.get(1).unwrap()[2].field1[0] == decoded.2.get(1).unwrap()[2].field1[0]);
	log(v.2.get(1).unwrap()[2].field1[1] == decoded.2.get(1).unwrap()[2].field1[1]);
	log(v.2.get(1).unwrap()[2].field1[2] == decoded.2.get(1).unwrap()[2].field1[2]);
	log(v.2.get(1).unwrap()[2].field1[3] == decoded.2.get(1).unwrap()[2].field1[3]);
	log(v.2.get(1).unwrap()[2].field1[4] == decoded.2.get(1).unwrap()[2].field1[4]);
	log(v.2.get(1).unwrap()[2].field2[0] == decoded.2.get(1).unwrap()[2].field2[0]);
	log(v.2.get(1).unwrap()[2].field2[1] == decoded.2.get(1).unwrap()[2].field2[1]);
	log(v.2.get(1).unwrap()[2].field3 == decoded.2.get(1).unwrap()[2].field3);
	log(v.2.get(1).unwrap()[2].field4.get_Variant1() == decoded.2.get(1).unwrap()[2].field4.get_Variant1());
	log(v.2.get(2).unwrap()[0].field1[0] == decoded.2.get(2).unwrap()[0].field1[0]);
	log(v.2.get(2).unwrap()[0].field1[1] == decoded.2.get(2).unwrap()[0].field1[1]);
	log(v.2.get(2).unwrap()[0].field1[2] == decoded.2.get(2).unwrap()[0].field1[2]);
	log(v.2.get(2).unwrap()[0].field1[3] == decoded.2.get(2).unwrap()[0].field1[3]);
	log(v.2.get(2).unwrap()[0].field1[4] == decoded.2.get(2).unwrap()[0].field1[4]);
	log(v.2.get(2).unwrap()[0].field2[0] == decoded.2.get(2).unwrap()[0].field2[0]);
	log(v.2.get(2).unwrap()[0].field2[1] == decoded.2.get(2).unwrap()[0].field2[1]);
	log(v.2.get(2).unwrap()[0].field3 == decoded.2.get(2).unwrap()[0].field3);
	log(v.2.get(2).unwrap()[0].field4.get_Variant1() == decoded.2.get(2).unwrap()[0].field4.get_Variant1());
	log(v.2.get(2).unwrap()[1].field1[0] == decoded.2.get(2).unwrap()[1].field1[0]);
	log(v.2.get(2).unwrap()[1].field1[1] == decoded.2.get(2).unwrap()[1].field1[1]);
	log(v.2.get(2).unwrap()[1].field1[2] == decoded.2.get(2).unwrap()[1].field1[2]);
	log(v.2.get(2).unwrap()[1].field1[3] == decoded.2.get(2).unwrap()[1].field1[3]);
	log(v.2.get(2).unwrap()[1].field1[4] == decoded.2.get(2).unwrap()[1].field1[4]);
	log(v.2.get(2).unwrap()[1].field2[0] == decoded.2.get(2).unwrap()[1].field2[0]);
	log(v.2.get(2).unwrap()[1].field2[1] == decoded.2.get(2).unwrap()[1].field2[1]);
	log(v.2.get(2).unwrap()[1].field3 == decoded.2.get(2).unwrap()[1].field3);
	log(v.2.get(2).unwrap()[1].field4.get_Variant1() == decoded.2.get(2).unwrap()[1].field4.get_Variant1());
	log(v.2.get(2).unwrap()[2].field1[0] == decoded.2.get(2).unwrap()[2].field1[0]);
	log(v.2.get(2).unwrap()[2].field1[1] == decoded.2.get(2).unwrap()[2].field1[1]);
	log(v.2.get(2).unwrap()[2].field1[2] == decoded.2.get(2).unwrap()[2].field1[2]);
	log(v.2.get(2).unwrap()[2].field1[3] == decoded.2.get(2).unwrap()[2].field1[3]);
	log(v.2.get(2).unwrap()[2].field1[4] == decoded.2.get(2).unwrap()[2].field1[4]);
	log(v.2.get(2).unwrap()[2].field2[0] == decoded.2.get(2).unwrap()[2].field2[0]);
	log(v.2.get(2).unwrap()[2].field2[1] == decoded.2.get(2).unwrap()[2].field2[1]);
	log(v.2.get(2).unwrap()[2].field3 == decoded.2.get(2).unwrap()[2].field3);
	log(v.2.get(2).unwrap()[2].field4.get_Variant1() == decoded.2.get(2).unwrap()[2].field4.get_Variant1());
    

    let v: [bool; 2] = [false, true];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[bool; 2]>(encoded);
    log(v[0] == decoded[0]);
	log(v[1] == decoded[1]);
	let mut bytes1 = Bytes::new();
	bytes1.push(199u8);
	bytes1.push(159u8);
	bytes1.push(194u8);
	bytes1.push(31u8);
    

    let v: Bytes = bytes1;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Bytes>(encoded);
    log(v == decoded);
	let mut vector2 : Vec<bool> = Vec::new();
	vector2.push(false);
	vector2.push(true);
	vector2.push(true);

	let mut vector3 : Vec<bool> = Vec::new();
	vector3.push(true);

	let mut vector4 : Vec<bool> = Vec::new();
	vector4.push(false);
	vector4.push(true);
	vector4.push(false);
	vector4.push(false);
	vector4.push(false);

	let mut vector5 : Vec<[u64; 5]> = Vec::new();
	vector5.push([10060067840141527141, 2112919794698382030, 495160946720519137, 13432544300176844121, 5905379759464946253]);
	vector5.push([1343733343715624853, 13016681752198238874, 13040392028499594782, 1646671609403619404, 5026300811524304345]);
	vector5.push([8647347682030595662, 12910216410573594028, 4254453942089670237, 6506131174076915885, 13600310929845160828]);
	vector5.push([2466074560085244674, 7044729763115721559, 1559317126289628172, 2802989063475670677, 3565976076844829444]);

	let mut vector6 : Vec<bool> = Vec::new();
	vector6.push(true);
    

    let v: [[Enum239; 5]; 2] = [[Enum239::Variant1(233u8), Enum239::Variant1(41u8), Enum239::Variant3(vector2), Enum239::Variant3(vector3), Enum239::Variant3(vector4)], [Enum239::Variant2(vector5), Enum239::Variant1(69u8), Enum239::Variant3(vector6), Enum239::Variant1(238u8), Enum239::Variant1(197u8)]];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[[Enum239; 5]; 2]>(encoded);
    log(v[0][0].get_Variant1() == decoded[0][0].get_Variant1());
	log(v[0][1].get_Variant1() == decoded[0][1].get_Variant1());
	log(v[0][2].get_Variant3().get(0).unwrap() == decoded[0][2].get_Variant3().get(0).unwrap());
	log(v[0][2].get_Variant3().get(1).unwrap() == decoded[0][2].get_Variant3().get(1).unwrap());
	log(v[0][2].get_Variant3().get(2).unwrap() == decoded[0][2].get_Variant3().get(2).unwrap());
	log(v[0][3].get_Variant3().get(0).unwrap() == decoded[0][3].get_Variant3().get(0).unwrap());
	log(v[0][4].get_Variant3().get(0).unwrap() == decoded[0][4].get_Variant3().get(0).unwrap());
	log(v[0][4].get_Variant3().get(1).unwrap() == decoded[0][4].get_Variant3().get(1).unwrap());
	log(v[0][4].get_Variant3().get(2).unwrap() == decoded[0][4].get_Variant3().get(2).unwrap());
	log(v[0][4].get_Variant3().get(3).unwrap() == decoded[0][4].get_Variant3().get(3).unwrap());
	log(v[0][4].get_Variant3().get(4).unwrap() == decoded[0][4].get_Variant3().get(4).unwrap());
	log(v[1][0].get_Variant2().get(0).unwrap()[0] == decoded[1][0].get_Variant2().get(0).unwrap()[0]);
	log(v[1][0].get_Variant2().get(0).unwrap()[1] == decoded[1][0].get_Variant2().get(0).unwrap()[1]);
	log(v[1][0].get_Variant2().get(0).unwrap()[2] == decoded[1][0].get_Variant2().get(0).unwrap()[2]);
	log(v[1][0].get_Variant2().get(0).unwrap()[3] == decoded[1][0].get_Variant2().get(0).unwrap()[3]);
	log(v[1][0].get_Variant2().get(0).unwrap()[4] == decoded[1][0].get_Variant2().get(0).unwrap()[4]);
	log(v[1][0].get_Variant2().get(1).unwrap()[0] == decoded[1][0].get_Variant2().get(1).unwrap()[0]);
	log(v[1][0].get_Variant2().get(1).unwrap()[1] == decoded[1][0].get_Variant2().get(1).unwrap()[1]);
	log(v[1][0].get_Variant2().get(1).unwrap()[2] == decoded[1][0].get_Variant2().get(1).unwrap()[2]);
	log(v[1][0].get_Variant2().get(1).unwrap()[3] == decoded[1][0].get_Variant2().get(1).unwrap()[3]);
	log(v[1][0].get_Variant2().get(1).unwrap()[4] == decoded[1][0].get_Variant2().get(1).unwrap()[4]);
	log(v[1][0].get_Variant2().get(2).unwrap()[0] == decoded[1][0].get_Variant2().get(2).unwrap()[0]);
	log(v[1][0].get_Variant2().get(2).unwrap()[1] == decoded[1][0].get_Variant2().get(2).unwrap()[1]);
	log(v[1][0].get_Variant2().get(2).unwrap()[2] == decoded[1][0].get_Variant2().get(2).unwrap()[2]);
	log(v[1][0].get_Variant2().get(2).unwrap()[3] == decoded[1][0].get_Variant2().get(2).unwrap()[3]);
	log(v[1][0].get_Variant2().get(2).unwrap()[4] == decoded[1][0].get_Variant2().get(2).unwrap()[4]);
	log(v[1][0].get_Variant2().get(3).unwrap()[0] == decoded[1][0].get_Variant2().get(3).unwrap()[0]);
	log(v[1][0].get_Variant2().get(3).unwrap()[1] == decoded[1][0].get_Variant2().get(3).unwrap()[1]);
	log(v[1][0].get_Variant2().get(3).unwrap()[2] == decoded[1][0].get_Variant2().get(3).unwrap()[2]);
	log(v[1][0].get_Variant2().get(3).unwrap()[3] == decoded[1][0].get_Variant2().get(3).unwrap()[3]);
	log(v[1][0].get_Variant2().get(3).unwrap()[4] == decoded[1][0].get_Variant2().get(3).unwrap()[4]);
	log(v[1][1].get_Variant1() == decoded[1][1].get_Variant1());
	log(v[1][2].get_Variant3().get(0).unwrap() == decoded[1][2].get_Variant3().get(0).unwrap());
	log(v[1][3].get_Variant1() == decoded[1][3].get_Variant1());
	log(v[1][4].get_Variant1() == decoded[1][4].get_Variant1());

  
return
}
