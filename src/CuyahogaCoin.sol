pragma solidity 0.8.13;

import "solmate/tokens/ERC20.sol";

contract CuyahogaCoin is ERC20 {
    address public owner;

    error OnlyOwner();

    modifier onlyOwner() {
        if (owner != msg.sender) {
            revert OnlyOwner();
        }
        _;
    }

    constructor (string memory _name, string memory _symbol, uint8 _decimals) ERC20(_name, _symbol, _decimals) {
            owner = msg.sender;
            _mint(msg.sender, 10 ether);
        }
    
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transferOwnership(address to) public onlyOwner {
        owner = to;
    }
}
