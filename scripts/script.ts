import { ethers } from "hardhat";

const main = async () => {
    const BetFactory = await ethers.getContractFactory("BetFactory");
    const betFactory = await BetFactory.deploy();
    await betFactory.deployed();

    console.log("Bet factory deployed to: ", betFactory.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log(error);
        process.exit(1);
    });
