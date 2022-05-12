pragma solidity 0.8.13;

import "solmate/tokens/ERC20.sol";
import "solmate/mixins/ERC4626.sol";
import "forge-std/console.sol";

contract JackVault is ERC20, ERC4626 {
    uint256 public beforeWithdrawCounter = 0;
    uint256 public afterDepositCounter = 0;

    constructor(
        ERC20 asset,
        string memory _name,
        string memory _symbol
    ) ERC4626(asset, _name, _symbol) {}

    function totalAssets() public view override returns (uint256) {
        return asset.balanceOf(address(this));
    }

    function beforeWithdraw(uint256 assets, uint256 shares) internal override {
        beforeWithdrawCounter++;
        console.log("before withdraw hit");
        console.log("assets", assets);
        console.log("shares", shares);
    }

    function afterDeposit(uint256 assets, uint256 shares) internal override {
        afterDepositCounter++;
        console.log("after deposit hit");
        console.log("assets", assets);
        console.log("shares", shares);
    }
}
