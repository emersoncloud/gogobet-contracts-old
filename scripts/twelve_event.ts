import { ethers } from "hardhat";

const main = async () => {

    // harhdhat network address
    // let address = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

    //local address
    let address = "0x52C84043CD9c865236f11d9Fc9F56aa003c1f922";
    const betFactory = await ethers.getContractAt("BetFactory", address);
    let test = await betFactory.return12();
    let realTest = await test.wait();
    console.log("testing", realTest);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log(error);
        process.exit(1);
    });
