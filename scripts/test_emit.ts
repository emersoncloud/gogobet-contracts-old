import { ethers } from "hardhat"
import { experimentalAddHardhatNetworkMessageTraceHook } from "hardhat/config"

const main = async () => {
    const [deployer, s1, s2, s3] = await ethers.getSigners();

    const BetFactory = await ethers.getContractFactory("BetFactory");
    const betFactory = await BetFactory.deploy();
    await betFactory.deployed();

    console.log("BetFactory deployed to: ", betFactory.address);

    const tx = await betFactory.newBet(10, s1.address, s2.address, s3.address, "test");
    const receipt = await tx.wait();

    let betContractAddress;
    for (const event of receipt.events) {
        betContractAddress = event.args[0];
        // console.log("event", event.args[0]);
        // console.log(`Event ${event.event} witih args ${event.args}`);
    }

    const betContract = await ethers.getContractAt("Bet", betContractAddress);
    let paidUpTx = await betContract.betPaidUp();
    console.log("is bet paid up?: ", paidUpTx);

    await betContract.connect(s1).putUp({value: ethers.utils.parseEther("10")});
    await betContract.connect(s2).putUp({value: ethers.utils.parseEther("10")});

    const s1HasPaid = await betContract.hasPaid(s1.address);
    console.log("s1 has paid", s1HasPaid);

    const s2HasPaid = await betContract.hasPaid(s2.address);
    console.log("s2 has paid", s2HasPaid);

    paidUpTx = await betContract.betPaidUp();
    console.log("is bet paid up?", paidUpTx);


    console.log("s1 balance before decision", ethers.utils.formatEther(await s1.getBalance()));
    await betContract.connect(s3).decision(s1.address);
    console.log("s1 balance after decision", ethers.utils.formatEther(await s1.getBalance()));

    const winner = await betContract.winner();
    console.log("winner address", winner);
    console.log("s1 address", s1.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });