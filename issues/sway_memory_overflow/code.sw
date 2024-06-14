script;

use std::vec::Vec;
use std::address::Address;
use core::codec::*;
use core::codec::Buffer;
use std::bytes::Bytes;
use std::string::String;

enum Enum263 {
	Variant1 : Vec<bool>,
}

impl Enum263 {
    fn get_Variant1(self) -> Vec<bool> {
        match self {
            Enum263::Variant1(v) => v,
            _ => revert(0),
        }
    }
}
struct Struct268 {
	field1 : str,
	field2 : Enum263,
}


fn main() -> () {

    

    let v: u32 = 1896606929;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u32>(encoded);
    log(v == decoded);
	let mut vector1 : Vec<u256> = Vec::new();
	vector1.push(0xe71c951298bdcacaa9fbe65db776339b073b09f60d84f3dfac44e82d49d099cbu256);
	vector1.push(0xfbbc8bc20ed99d6d73e60fe871342bda0bb65af5ef201e32be4f0841a558e1bdu256);
	vector1.push(0xcbebf86f2ee32955e3afa57daa0ebe6db23889ccb256e825d032a63529a0861eu256);
	vector1.push(0xd27cd21a0de5c72d961813fd871b0dea6df4fbe60dea987182b2faaa324729c9u256);

	let mut vector2 : Vec<u256> = Vec::new();
	vector2.push(0x5d424300485722a8287100514c2ec76a04cedc7b83bcfe0111c76ba07b7fa268u256);
	vector2.push(0xb28bf5746e6ae790d5f002f30503b78faae2f2322b2f7932e6fa7a99cd70d5c4u256);
	vector2.push(0xddb71886e105d2b2a0a97b8d71a635cf940d7d12ac3fcc4c868a48064cc2f5e5u256);
	vector2.push(0xf344d4bacc43e2e0df4bd65f3001a781633cea040cc5084b1c72811bbb110159u256);
	vector2.push(0xa9a6da81b807a077a821093064d728ead58501bc772ef2bcaf3dd3891f9e8488u256);

	let mut vector3 : Vec<u256> = Vec::new();
	vector3.push(0xbce732bc10e588a7086254f0b22e7c5c362d7b65b97d6138e24328edb6b4d04u256);
	vector3.push(0xe6c754a3cffc974d28a5a08192ddc896ae6d249d76853190798738f738b7011du256);
	vector3.push(0xaa3985470adeacf59249b5d36722e9f32ab01c4647847dcc4f369adba358a6e1u256);
	vector3.push(0xb452477ef40843ec5fb4c37b07cca2b1e56862ff10892039fade32dc3778e351u256);
	vector3.push(0x96c4f6a1da23dc201ab9ede5675e2b7b7832fdc91ec73dd949247c05e5555000u256);

	let mut vector4 : Vec<u256> = Vec::new();
	vector4.push(0x1919c0293db51bda0642598a4ff0954486d493ad53379c6c3e434ff8276df42au256);
	vector4.push(0x23ea17da0667fe066ae210949e4252dd01f9960d6395e8ca20fee579bcc9ee51u256);
	vector4.push(0x6587b25304c7aa606d675165caf14aa1ba84188be515ad7d44ada6fa83e52524u256);
	vector4.push(0xf6e370a765dde0b7d6850f1263fa6f3f787af6b82ea053c3d4766cd6b566544eu256);
	vector4.push(0x496ea8f25f3f64058ea70c0e69d99a92dffec959acde79aba05685ddc2403ddbu256);

	let mut vector0 : Vec<Vec<u256>> = Vec::new();
	vector0.push(vector1);
	vector0.push(vector2);
	vector0.push(vector3);
	vector0.push(vector4);

	let mut vector6 : Vec<u256> = Vec::new();
	vector6.push(0xea4a8fd3b8bd999727a10205c88675a7e4ff58e1b9da50fbc0dd0a2db4a9010du256);
	vector6.push(0x47e2e5b3a24423c7f10dae82a091e2f418f24a666cdbe96d047975df7bc1b6a3u256);
	vector6.push(0xf0fcea33c4f0815253e0781193e0389fe9a9e00432482b03545748219d708aeau256);

	let mut vector7 : Vec<u256> = Vec::new();
	vector7.push(0x6b21db1bdeb64875baefe9297521539430408eb21ba43c2836cfe7fa00ee906eu256);

	let mut vector5 : Vec<Vec<u256>> = Vec::new();
	vector5.push(vector6);
	vector5.push(vector7);

	let mut vector9 : Vec<u256> = Vec::new();
	vector9.push(0x800237cf3e584ca77d23a2fa5220a4a24a466fc61e4c3f6ad22f60eada549343u256);
	vector9.push(0x485141a696352f7753b3c4de7a7265f69b594533345e25452fd0137bb64313f3u256);
	vector9.push(0x74edf5d7efba87ea751c4a2059c7a57dce57bc68bdae1c0b7ff2fadcd039bacfu256);
	vector9.push(0x69967231aae34ad005e8fb6d07d6a173ccacbc2b8c0d2c241c2f6493ec69bcaau256);

	let mut vector10 : Vec<u256> = Vec::new();
	vector10.push(0x9bef16700d99f6047ddf356c8a9c121752b6d688012468bd4e7fb169d9d52bbdu256);
	vector10.push(0x8afd91618823d6e4da6c7566f4b819d4ab394dbb183ca9d0fb0b09dd68375a5cu256);

	let mut vector8 : Vec<Vec<u256>> = Vec::new();
	vector8.push(vector9);
	vector8.push(vector10);

	let mut vector12 : Vec<u256> = Vec::new();
	vector12.push(0xb95fa3707c77c2680445782fc872d3724b28502248f89f8c3ec7ca5dd33a9f6cu256);
	vector12.push(0x348ed480a32c0c94b5422bf241c81085264aeb68d81f3c4b56e6eda267429bb6u256);
	vector12.push(0x33ceea00a50dd94a833f30ddf35f153eb4fb2be6433fb9a4e6e7d3467b18ea08u256);

	let mut vector13 : Vec<u256> = Vec::new();
	vector13.push(0xba0ede1ce998602d0e208868d7b55628daeae1cf6c832a1796c3dff7316cb894u256);
	vector13.push(0x10a71d0321d1783a5133542860b34533b3c047bcb52da42a9558f32ed48ce515u256);
	vector13.push(0xdbadb3597999da6c6c4d6f7b96a1cd58c12f61dbbf91ad08930498c93b468cf1u256);
	vector13.push(0x1f68c2bdd3352dafaa91fa7aff8c11ffed4c7ccab1ca62864456c016f68a086bu256);

	let mut vector14 : Vec<u256> = Vec::new();
	vector14.push(0xe5855876098878850b97fa5a081561703c67b16f854da8716289c0f37306fb24u256);
	vector14.push(0xd4ce62458f20e570a2a327e4f012f576a955ad7fdf20af2ade301fc100b6cca0u256);
	vector14.push(0x5a9f489f91198ccae48a89132977f82a4ed2b5212b506a4e5f79d024a677f11au256);
	vector14.push(0x6827bc3bea7c8805cb2702413fb152d0f6c763ea3289e0200416519486a29230u256);

	let mut vector15 : Vec<u256> = Vec::new();
	vector15.push(0xf7f6e053a6a515448684068e3189822ed07ac85d433c11005febf79e92fc7b60u256);

	let mut vector16 : Vec<u256> = Vec::new();
	vector16.push(0x6007e438fdec30a9189690a275fe2dc7cc88b4e02eea3610e2590f1eac1cf733u256);
	vector16.push(0x63fa9dc2fb7d40a145f33d6b6a898cb5a2075965e5dd25f110ed4c846620a2bcu256);
	vector16.push(0x731d6ad0520d6c1d052eed90233694117bb3c62881c71f4f24d67feb40441173u256);
	vector16.push(0x5d011e0bb30147caa37277a453c148ca85f4f776e3a72f8bb91828fbfba3f960u256);

	let mut vector11 : Vec<Vec<u256>> = Vec::new();
	vector11.push(vector12);
	vector11.push(vector13);
	vector11.push(vector14);
	vector11.push(vector15);
	vector11.push(vector16);
    

    let v: [Vec<Vec<u256>>; 4] = [vector0, vector5, vector8, vector11];
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<[Vec<Vec<u256>>; 4]>(encoded);
    log(v[0].get(0).unwrap().get(0).unwrap() == decoded[0].get(0).unwrap().get(0).unwrap());
	log(v[0].get(0).unwrap().get(1).unwrap() == decoded[0].get(0).unwrap().get(1).unwrap());
	log(v[0].get(0).unwrap().get(2).unwrap() == decoded[0].get(0).unwrap().get(2).unwrap());
	log(v[0].get(0).unwrap().get(3).unwrap() == decoded[0].get(0).unwrap().get(3).unwrap());
	log(v[0].get(1).unwrap().get(0).unwrap() == decoded[0].get(1).unwrap().get(0).unwrap());
	log(v[0].get(1).unwrap().get(1).unwrap() == decoded[0].get(1).unwrap().get(1).unwrap());
	log(v[0].get(1).unwrap().get(2).unwrap() == decoded[0].get(1).unwrap().get(2).unwrap());
	log(v[0].get(1).unwrap().get(3).unwrap() == decoded[0].get(1).unwrap().get(3).unwrap());
	log(v[0].get(1).unwrap().get(4).unwrap() == decoded[0].get(1).unwrap().get(4).unwrap());
	log(v[0].get(2).unwrap().get(0).unwrap() == decoded[0].get(2).unwrap().get(0).unwrap());
	log(v[0].get(2).unwrap().get(1).unwrap() == decoded[0].get(2).unwrap().get(1).unwrap());
	log(v[0].get(2).unwrap().get(2).unwrap() == decoded[0].get(2).unwrap().get(2).unwrap());
	log(v[0].get(2).unwrap().get(3).unwrap() == decoded[0].get(2).unwrap().get(3).unwrap());
	log(v[0].get(2).unwrap().get(4).unwrap() == decoded[0].get(2).unwrap().get(4).unwrap());
	log(v[0].get(3).unwrap().get(0).unwrap() == decoded[0].get(3).unwrap().get(0).unwrap());
	log(v[0].get(3).unwrap().get(1).unwrap() == decoded[0].get(3).unwrap().get(1).unwrap());
	log(v[0].get(3).unwrap().get(2).unwrap() == decoded[0].get(3).unwrap().get(2).unwrap());
	log(v[0].get(3).unwrap().get(3).unwrap() == decoded[0].get(3).unwrap().get(3).unwrap());
	log(v[0].get(3).unwrap().get(4).unwrap() == decoded[0].get(3).unwrap().get(4).unwrap());
	log(v[1].get(0).unwrap().get(0).unwrap() == decoded[1].get(0).unwrap().get(0).unwrap());
	log(v[1].get(0).unwrap().get(1).unwrap() == decoded[1].get(0).unwrap().get(1).unwrap());
	log(v[1].get(0).unwrap().get(2).unwrap() == decoded[1].get(0).unwrap().get(2).unwrap());
	log(v[1].get(1).unwrap().get(0).unwrap() == decoded[1].get(1).unwrap().get(0).unwrap());
	log(v[2].get(0).unwrap().get(0).unwrap() == decoded[2].get(0).unwrap().get(0).unwrap());
	log(v[2].get(0).unwrap().get(1).unwrap() == decoded[2].get(0).unwrap().get(1).unwrap());
	log(v[2].get(0).unwrap().get(2).unwrap() == decoded[2].get(0).unwrap().get(2).unwrap());
	log(v[2].get(0).unwrap().get(3).unwrap() == decoded[2].get(0).unwrap().get(3).unwrap());
	log(v[2].get(1).unwrap().get(0).unwrap() == decoded[2].get(1).unwrap().get(0).unwrap());
	log(v[2].get(1).unwrap().get(1).unwrap() == decoded[2].get(1).unwrap().get(1).unwrap());
	log(v[3].get(0).unwrap().get(0).unwrap() == decoded[3].get(0).unwrap().get(0).unwrap());
	log(v[3].get(0).unwrap().get(1).unwrap() == decoded[3].get(0).unwrap().get(1).unwrap());
	log(v[3].get(0).unwrap().get(2).unwrap() == decoded[3].get(0).unwrap().get(2).unwrap());
	log(v[3].get(1).unwrap().get(0).unwrap() == decoded[3].get(1).unwrap().get(0).unwrap());
	log(v[3].get(1).unwrap().get(1).unwrap() == decoded[3].get(1).unwrap().get(1).unwrap());
	log(v[3].get(1).unwrap().get(2).unwrap() == decoded[3].get(1).unwrap().get(2).unwrap());
	log(v[3].get(1).unwrap().get(3).unwrap() == decoded[3].get(1).unwrap().get(3).unwrap());
	log(v[3].get(2).unwrap().get(0).unwrap() == decoded[3].get(2).unwrap().get(0).unwrap());
	log(v[3].get(2).unwrap().get(1).unwrap() == decoded[3].get(2).unwrap().get(1).unwrap());
	log(v[3].get(2).unwrap().get(2).unwrap() == decoded[3].get(2).unwrap().get(2).unwrap());
	log(v[3].get(2).unwrap().get(3).unwrap() == decoded[3].get(2).unwrap().get(3).unwrap());
	log(v[3].get(3).unwrap().get(0).unwrap() == decoded[3].get(3).unwrap().get(0).unwrap());
	log(v[3].get(4).unwrap().get(0).unwrap() == decoded[3].get(4).unwrap().get(0).unwrap());
	log(v[3].get(4).unwrap().get(1).unwrap() == decoded[3].get(4).unwrap().get(1).unwrap());
	log(v[3].get(4).unwrap().get(2).unwrap() == decoded[3].get(4).unwrap().get(2).unwrap());
	log(v[3].get(4).unwrap().get(3).unwrap() == decoded[3].get(4).unwrap().get(3).unwrap());
    

    let v: u256 = 0xbc1ca567817c45c12874107df73db857d8841122f1e08a429b1d251a9b871f29u256;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u256>(encoded);
    log(v == decoded);
    

    let v: u8 = 140u8;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<u8>(encoded);
    log(v == decoded);
	let mut vector18 : Vec<bool> = Vec::new();
	vector18.push(false);

	let mut vector17 : Vec<Struct268> = Vec::new();
	vector17.push(Struct268 {field1 : "~",field2 : Enum263::Variant1(vector18),});
    

    let v: Vec<Struct268> = vector17;
        
    let mut buffer = Buffer::new();
    let mut encoded = v.abi_encode(buffer).as_raw_slice();
    log(encoded);

    let decoded = abi_decode::<Vec<Struct268>>(encoded);
    log(v.get(0).unwrap().field1 == decoded.get(0).unwrap().field1);
	log(v.get(0).unwrap().field2.get_Variant1().get(0).unwrap() == decoded.get(0).unwrap().field2.get_Variant1().get(0).unwrap());

  
return
}
