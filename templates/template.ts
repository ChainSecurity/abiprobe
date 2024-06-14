import {ArrayCoder,
        B256Coder,
        BigNumberCoder,
        BooleanCoder,
        ByteCoder,
        EnumCoder,
        NumberCoder,
        RawSliceCoder,
        StdStringCoder,
        StringCoder,
        StrSliceCoder,
        StructCoder,
        TupleCoder,
        VecCoder,
        bn, BNInput } from "fuels";


function isEqual(value1: any, value2: any): boolean {
    console.log("Inspecting values:", value1,  value2);
    if (value1 === value2) return true;

    if (typeof value1.eq === "function" && value1.eq(value2)){
        return true;
    }

    if (value1 == null || value2 == null){
      console.log("Value is null!");
      return false;
    }


    // if (typeof value1 !== 'object' || typeof value2 !== 'object'){
    //     console.log("One value is not an object")
    //     return false;
    // }

    let keys1 = Object.keys(value1);
    let keys2 = Object.keys(value2);

    if (keys1.length == 1 && value1[keys1[0]].length == 0 && keys1[0] == value2){
    // Assume:
    // enum MyEnum{
    //      a: ()
    // }
    // This is encoded as {a: []} but decoded as ['a'].
    // We conclude they are the same as long as the key of the first value equals
    // the second value.
        return true
    }

    if (keys1.length !== keys2.length) {
        console.log("Keys with different length!")
        return false;
    }

    for (let key of keys1) {
        console.log("Inpsecting key:", key);
        if (!keys2.includes(key)){
            console.log("Key not included!")
            return false;
        }
        if (!isEqual(value1[key], value2[key])){
            console.log(value1[key]['Variant1'],  value2[key])
            console.log("Different values!")
            return false;
        }
    }

    return true;
}

{custom_types}

{testcases}
