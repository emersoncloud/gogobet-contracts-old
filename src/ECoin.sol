pragma solidity 0.8.13;

import "solmate/tokens/ERC20.sol";

contract ECoin is ERC20 {
    constructor() ERC20("ECoin", "EC", 18) {}

    function mint(address to, uint256 value) public virtual {
        _mint(to, value);
    }

    function burn(address from, uint256 value) public virtual {
        _burn(from, value);
    }
}
