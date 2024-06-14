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
        if (typeof value1 !== 'object' || typeof value2 !== 'object'){
            return false;
        }

        let keys1 = Object.keys(value1);
        let keys2 = Object.keys(value2);

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

                console.log("Different values!")
                return false;
            }
        }

        return true;
}




{
    
    const v : any = [19007, { Variant2: 'e' }];
    const coder = new TupleCoder<[NumberCoder,EnumCoder<any>]>([new NumberCoder('u16'),new EnumCoder('Enum0', {Variant1: new StructCoder('Struct2', {field1: new NumberCoder('u16'),field2: new NumberCoder('u16'),field3: new ByteCoder(),field4: new StrSliceCoder(),field5: new RawSliceCoder()}),Variant2: new StrSliceCoder()})]);
    const encoded = coder.encode(v);

    console.log(`Encoding[${Array.from(encoded).join(",")}]`);

    const [decodedValue, decodedLength] = coder.decode(encoded, 0);
    console.log(`Decoding[${isEqual(v, decodedValue)}]`);
}
        

