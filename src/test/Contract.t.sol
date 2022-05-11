// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.10;

import "ds-test/test.sol";
import "../Contract.sol";

contract ContractTest is DSTest {
    Contract test;

    function setUp() public {
        test = new Contract();
    }

    function testExample() public {
        assertTrue(true);
    }
}
