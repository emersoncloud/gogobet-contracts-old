// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Bet {
    uint32 public amount;
    address public partyOne;
    address public partyTwo;
    address public oracle;
    string public description;

    constructor (
        uint32 _amount,
        address _partyOne,
        address _partyTwo,
        address _oracle,
        string memory _description
    ) {
        amount = _amount;
        partyOne = _partyOne;
        partyTwo = _partyTwo;
        oracle = _oracle;
        description = _description;
    }
}
