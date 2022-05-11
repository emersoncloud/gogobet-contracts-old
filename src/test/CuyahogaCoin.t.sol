pragma solidity 0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../CuyahogaCoin.sol";

contract CuyahogaCoinTest is Test {
    uint256 private randAddressNonce = 0;
    CuyahogaCoin coin;

    function setUp() public {
        coin = new CuyahogaCoin("cuyahogacoin", "cc", 18);
    }

    function testMint() public {
        address addr1 = address(
            uint160(uint256(keccak256((abi.encodePacked("test")))))
        );

        coin.mint(addr1, 10 ether);

        assertEq(coin.balanceOf(addr1), 10 ether);
    }

    function testTransfer() public {
        address a1 = randomAddress();
        address a2 = randomAddress();

        coin.mint(a1, 22 ether);
        assertEq(coin.balanceOf(a1), 22 ether);

        vm.prank(a1);
        coin.transfer(a2, 2 ether);
        assertEq(coin.balanceOf(a1), 20 ether);
        assertEq(coin.balanceOf(a2), 2 ether);
    }

    function testOwnershipTransfer() public {
        address originalOwner = coin.owner();
        address newOwner = randomAddress();
        address randAddress = randomAddress();

        assertEq(coin.owner(), originalOwner);

        coin.transferOwnership(newOwner);
        assertEq(coin.owner(), newOwner);

        vm.expectRevert(CuyahogaCoin.OnlyOwner.selector);
        coin.mint(randAddress, 1 ether);
        assertEq(coin.balanceOf(randAddress), 0 ether);
    }

    function randomAddress() internal returns (address) {
        randAddressNonce++;
        return
            address(
                uint160(
                    uint256(
                        keccak256(
                            abi.encodePacked(
                                randAddressNonce,
                                blockhash(block.number)
                            )
                        )
                    )
                )
            );
    }
}
