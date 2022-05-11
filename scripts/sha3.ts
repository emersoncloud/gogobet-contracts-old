import { artifacts, ethers } from "hardhat";
import { web3 } from "hardhat";

const main = async () => {
  let hashTest = web3.utils.sha3("test");
  let hTest = web3.utils.keccak256("test");
  artifacts.require("Bet.sol");
  console.log(hashTest);
  console.log(hTest);
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
