import { ethers } from "hardhat";
import { experimentalAddHardhatNetworkMessageTraceHook, HardhatUserConfig, task } from "hardhat/config";

const main = async () => {
    const BetFactory = await ethers.getContractFactory("BefFactory");
}
