// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "forge-std/Test.sol";
import "../BetFactory.sol";
import "../Bet.sol";

contract BetFactoryTest is Test {
    uint256 private randNonce = 0;
	function randAddress() internal returns (address) {
		randNonce++;
		return address(uint160(uint256(keccak256(abi.encodePacked(randNonce, blockhash(block.timestamp))))));
	}

    BetFactory private betFactory;

    function setUp() public {
        betFactory = new BetFactory();
    }

    function testNewBet() public {
        uint32 betAmount = 10;
        address partyOne = randAddress();
        address partyTwo = randAddress();
        address oracle = randAddress();
        string memory description = "test-description";

        betFactory.newBet(
            betAmount,
            partyOne,
            partyTwo,
            oracle,
            description
        );
    }
}
