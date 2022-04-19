// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../Bet.sol";

contract BetTest is Test {
    uint256 private randNonce = 0;
	function randAddress() internal returns (address) {
		randNonce++;
		return address(uint160(uint256(keccak256(abi.encodePacked(randNonce, blockhash(block.timestamp))))));
	}

    // magic address forge deploys all contracts from
    address private constant GUARDIAN = address(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84);

    Bet private bet;

    uint32 private betAmount = 10;
    address private partyOne = randAddress();
    address private partyTwo = randAddress();
    address private oracle = randAddress();
    string private description = "test-description";

    function setUp() public {
        bet = new Bet(
            betAmount,
            partyOne,
            partyTwo,
            oracle,
            description
        );
    }

    function testPublicParameters() public {
        assertEq(betAmount, bet.betAmount());
        assertEq(partyOne, bet.partyOne());
        assertEq(partyTwo, bet.partyTwo());
        assertEq(oracle, bet.oracle());
        assertEq(description, bet.description());
    }

    function testPutUp() public {
        vm.deal(partyOne, 200);
        vm.prank(partyOne);
        bet.putUp{value: 10}();

        assertEq(10, address(bet).balance);
        assertTrue(bet.hasPaid(partyOne));
    }
    
    function testBetPaidUp() public {
        vm.deal(partyOne, 200);
        vm.deal(partyTwo, 200);

        vm.prank(partyOne);
        bet.putUp{value: 10}();

        vm.prank(partyTwo);
        bet.putUp{value: 10}();

        assertTrue(bet.betPaidUp());
    }

    function testDecision() public {
        // test before bet has paid up
        vm.prank(oracle);
        vm.expectRevert("the bet has not been full paid yet");
        bet.decision(partyOne);

        // test after both parties pay
        vm.deal(partyOne, 10);
        vm.deal(partyTwo, 10);

        vm.prank(partyOne);
        bet.putUp{value: 10}();

        vm.prank(partyTwo);
        bet.putUp{value: 10}();
        

        vm.prank(oracle);  
        bet.decision(partyOne);
        assertEq(bet.winner(), partyOne);
        assertEq(20, partyOne.balance);
    }

    function testOnlyOracleDecision() public {
        bytes memory customError = abi.encodeWithSelector(Bet.OnlyOracle.selector);
        vm.expectRevert(customError);
        bet.decision(partyOne);
    }
}

