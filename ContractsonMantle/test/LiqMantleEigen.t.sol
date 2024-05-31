// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/LiqMantleEigen.sol";

contract LiqMantleEigenTest is Test {
    LiqMantleEigen token;
    address admin;
    address recipient;

    function setUp() public {
        admin = address(this);  // Set the test contract as the admin
        recipient = address(0x1);
        token = new LiqMantleEigen();
    }

    function testAdminMinting() public {
        uint256 mintAmount = 1000 * 10 ** 18; // Mint 1000 tokens, considering decimals
        token.mint(recipient, mintAmount); // As admin, try to mint tokens to recipient

        // Check if the recipient got the minted amount
        assertEq(token.balanceOf(recipient), mintAmount, "Minting failed: Balance does not match.");
    }

    function testUnauthorizedMinting() public {
        uint256 mintAmount = 1000 * 10 ** 18; // Try to mint 1000 tokens
        vm.prank(recipient);  // Impersonate a non-admin address
        vm.expectRevert("Only admin can mint");
        token.mint(recipient, mintAmount); // This should fail
    }

    function testInitialAdminIsDeployer() public view {
        // The admin should be the deployer (this contract in tests)
        assertEq(token.admin(), admin, "Admin is not correctly set.");
    }
}
