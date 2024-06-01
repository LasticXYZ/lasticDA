// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/LiqMantleEigen.sol";
import "../src/OracleMock.sol";

contract LiqMantleEigenTest is Test {
    LiqMantleEigen liqMantleEigen;
    OracleMock oracleMock;
    address admin;
    address user1;
    address user2;

    function setUp() public {
        admin = address(this);  // Test contract is the admin
        user1 = address(0x1);
        user2 = address(0x2);
        oracleMock = new OracleMock();
        liqMantleEigen = new LiqMantleEigen(address(oracleMock));
        oracleMock.setContribution(user1, 100);
        oracleMock.setContribution(user2, 200);
        vm.prank(user1);
        liqMantleEigen.registerUser();
        vm.prank(user2);
        liqMantleEigen.registerUser();
    }

    function testAdminSetCorrectly() public view {
        assertEq(liqMantleEigen.admin(), admin, "Admin should be the deployer");
    }

    function testRegisterUserAndFetchContributions() public view {
        uint256 contribution = liqMantleEigen.userContributions(user1);
        assertEq(contribution, 100, "Contribution should match oracle data");
    }

    function testTokenDistribution() public {
        // Check current user contributions to ensure they are as expected
        uint256 contributionUser1 = liqMantleEigen.userContributions(user1);
        uint256 contributionUser2 = liqMantleEigen.userContributions(user2);
        emit log_named_uint("Contribution User 1", contributionUser1);
        emit log_named_uint("Contribution User 2", contributionUser2);

        // Ensure that enough blocks have passed since the last mint
        uint256 blocksToAdvance = 100 - (block.number - liqMantleEigen.lastMintBlock()) + 1;
        vm.roll(block.number + blocksToAdvance);

        // Now attempt to mint and distribute tokens
        vm.startPrank(admin);
        liqMantleEigen.mintAndDistributeTokens();
        vm.stopPrank();

        uint256 balanceUser1 = liqMantleEigen.balanceOf(user1);
        uint256 balanceUser2 = liqMantleEigen.balanceOf(user2);
        emit log_named_uint("Balance User 1", balanceUser1);
        emit log_named_uint("Balance User 2", balanceUser2);

        assertTrue(balanceUser1 < balanceUser2, "User2 should receive more tokens than User1");
    }


    function testNonAdminCannotDistributeTokens() public {
        vm.prank(user1);
        vm.expectRevert("Only admin can distribute tokens");
        liqMantleEigen.mintAndDistributeTokens();
    }
}
