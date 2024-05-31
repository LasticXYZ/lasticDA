// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/EigenToken.sol";

contract EigenTokenTest is Test {
    EigenToken token;
    address deployer;
    address user;

    function setUp() public {
        deployer = address(this);  // The contract itself will act as the deployer
        user = address(0x1);  // A second test user
        token = new EigenToken();

        // Give the user some tokens to play with
        token.transfer(user, 5000 * 10 ** token.decimals());
    }

    function testLockingTokens() public {
        uint256 lockAmount = 1000 * 10 ** token.decimals();
        uint256 currentTime = block.timestamp;
        uint256 lockDuration = 1 days;

        vm.prank(user);
        token.lockTokens(lockAmount, lockDuration);

        // Access the lock struct to ensure it was created correctly using the new accessor
        (uint256 lockedAmount, uint256 unlockTime) = token.getLockForUser(user, 0);
        assertEq(lockedAmount, lockAmount, "Lock amount incorrect.");
        assertEq(unlockTime, currentTime + lockDuration, "Unlock time incorrect.");
    }


    function testUnlockingTokens() public {
        uint256 lockAmount = 1000 * 10 ** token.decimals();
        uint256 lockDuration = 1 days;

        vm.prank(user);
        token.lockTokens(lockAmount, lockDuration);

        // Attempt to unlock before the duration has passed
        vm.prank(user);
        vm.expectRevert("Tokens are still locked.");
        token.unlockTokens();

        // Move the block timestamp forward to simulate time passing
        vm.warp(block.timestamp + lockDuration);

        // Unlock tokens
        vm.prank(user);
        token.unlockTokens();

        // Check that the user's balance has been restored
        assertEq(token.balanceOf(user), 5000 * 10 ** token.decimals(), "Tokens were not unlocked correctly.");
    }

    function testCannotLockZeroAmount() public {
        vm.prank(user);
        vm.expectRevert("Amount must be greater than 0");
        token.lockTokens(0, 1 days);
    }
}
