import { ethers } from "hardhat";
import { experimentalAddHardhatNetworkMessageTraceHook, HardhatUserConfig, task } from "hardhat/config";

const main = async () => {

    let address = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
    const betFactory = await ethers.getContractAt("BetFactory", address);
    let test = await betFactory.return12();
    console.log("testing", test);

    // const BetFactory = await ethers.getContractFactory("BetFactory");
    // const betFactory = await BetFactory.deploy();
    // await betFactory.deployed();

    // console.log("Bet factory deployed to: ", betFactory.address);
    // let onetwo = await betFactory.return12();
    // console.log(onetwo);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log(error);
        process.exit(1);
    });
