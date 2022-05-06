import {ethers} from "hardhat";

const main = async () => {
    const [deployer] = await ethers.getSigners();
    const BetFactory = await ethers.getContractFactory("BetFactoroy");
    const betFactory = await BetFactory.deploy();
    await betFactory.deployed();

    console.log("BetFactory deployed to: ", betFactory.address);

    const tx = await betFactory.returns12();
    console.log("tx", tx);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });