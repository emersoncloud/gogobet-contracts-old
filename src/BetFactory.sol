// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "./Bet.sol";

contract BetFactory {
    event BetCreated(
        address newBet,
        uint32 betAmount,
        address indexed partyOne,
        address indexed partyTwo,
        address indexed oracle,
        string description
    );

    function newBet(
        uint32 _betAmount,
        address _partyOne,
        address _partyTwo,
        address _oracle,
        string memory _description
    ) public {
        Bet bet = new Bet(
            _betAmount,
            _partyOne,
            _partyTwo,
            _oracle,
            _description
        );

        emit BetCreated(
            address(bet),
            _betAmount,
            _partyOne,
            _partyTwo,
            _oracle,
            _description
        );
    }
}