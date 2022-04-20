// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Bet {
    uint32 public betAmount;
    address public partyOne;
    address public partyTwo;
    address public oracle;
    address public winner;
    string public description;

    mapping(address => bool) public hasPaid;

    error OnlyOracle();

    modifier onlyOracle() {
        if (msg.sender != oracle) {
            revert OnlyOracle();
        }
        _;
    }
    
    modifier betParties(address _better) {
        require(_better == partyOne || _better == partyTwo, "not part of the bet");
        _;
    }

    constructor (
        uint32 _betAmount,
        address _partyOne,
        address _partyTwo,
        address _oracle,
        string memory _description
    ) {
        betAmount = _betAmount;
        partyOne = _partyOne;
        partyTwo = _partyTwo;
        oracle = _oracle;
        description = _description;
    }

    function putUp() public payable {
        require(msg.value >= betAmount, "must pay bet amount or more");
        require(hasPaid[msg.sender] == false, "you've already paid!");

        hasPaid[msg.sender] = true;
    }

    function decision(address _winner) public onlyOracle {
        require(_winner == partyOne || winner == partyTwo, "Winner must be part of the bet");
        require(betPaidUp(), "the bet has not been full paid yet");

        (bool sent,) = _winner.call{value: address(this).balance}("");
        require(sent, "Failed to send ether");

        winner = _winner;
    }

    function betPaidUp() public view returns (bool betPaidState) {
        return hasPaid[partyOne] && hasPaid[partyTwo];
    }
}
