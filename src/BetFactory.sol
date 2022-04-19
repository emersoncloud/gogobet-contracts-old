// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "./Bet.sol";

contract BetFactory {

    function newBet(
        uint32 _betAmount,
        address _partyOne,
        address _partyTwo,
        address _oracle,
        string memory _description
    ) public {
        new Bet(
            _betAmount,
            _partyOne,
            _partyTwo,
            _oracle,
            _description
        );
    }
}