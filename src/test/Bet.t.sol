// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "ds-test/test.sol";
import "../Bet.sol";

contract BetTest is DSTest {
    uint256 private randNonce = 0;
	function randAddress() internal returns (address) {
		randNonce++;
		return address(uint160(uint256(keccak256(abi.encodePacked(randNonce, blockhash(block.timestamp))))));
	}

    // magic address forge deploys all contracts from
    address private constant GUARDIAN = address(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84);

    Bet private bet;

    uint32 private amount = 10;
    address private partyOne = randAddress();
    address private partyTwo = randAddress();
    address private oracle = randAddress();
    string private description = "test-description";

    function setUp() public {
        bet = new Bet(
            amount,
            partyOne,
            partyTwo,
            oracle,
            description
        );
    }

    function testPublicParameters() public {
        assertEq(amount, bet.amount());
        assertEq(partyOne, bet.partyOne());
        assertEq(partyTwo, bet.partyTwo());
        assertEq(oracle, bet.oracle());
        assertEq(description, bet.description());
    }
}

