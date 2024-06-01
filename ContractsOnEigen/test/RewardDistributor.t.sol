// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/RewardDistributor.sol";  // Adjust the path as necessary
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockEigenToken is ERC20 {
    constructor() ERC20("MockEigenToken", "MET") {
        _mint(msg.sender, 1000000 * 10**18);  // Mint some tokens for testing
    }

    function approveAndCall(address spender, uint256 amount) external {
        _approve(msg.sender, spender, amount);
    }
}

contract RewardDistributorTest is Test {
    RewardDistributor distributor;
    MockEigenToken eigenToken;
    address user1;
    address user2;

    function setUp() public {
        eigenToken = new MockEigenToken();
        distributor = new RewardDistributor(address(eigenToken));
        
        // Using predefined addresses from Foundry's test environment
        user1 = address(1);
        user2 = address(2);

        // Transfer some tokens to these user addresses
        eigenToken.transfer(user1, 1000 * 10**18);
        eigenToken.transfer(user2, 1000 * 10**18);

        // Approve the distributor to use tokens on behalf of user1 and user2
        vm.prank(user1);
        eigenToken.approve(address(distributor), 1000 * 10**18);
        vm.stopPrank();
        
        vm.prank(user2);
        eigenToken.approve(address(distributor), 1000 * 10**18);
        vm.stopPrank();
    }

    function testLockAndUnlockTokens() public {
        uint256 lockAmount = 500 * 10**18;
        uint256 time = 30 days;

        // User1 locks some tokens
        vm.startPrank(user1);
        distributor.lockTokens(lockAmount, time);
        assertEq(eigenToken.balanceOf(user1), 500 * 10**18, "Token lock failed");

        // Time travel to after the lock period
        vm.warp(block.timestamp + time + 1);

        // Unlock tokens
        distributor.unlockTokens();
        assertEq(eigenToken.balanceOf(user1), 900 * 10**18, "Token unlock failed");  // Expecting 80% back
        vm.stopPrank();
    }

    function testVoteForProject() public {
        // Adding a project as owner
        address project = address(1);
        distributor.addProject(project);

        // User1 votes for the project
        uint256 voteAmount = 100 * 10**18;
        vm.startPrank(user1);
        distributor.voteForProject(0, voteAmount);
        assertEq(distributor.votes(project), voteAmount, "Voting failed");
        vm.stopPrank();
    }

    function testDistributeRewards() public {
        address project = address(1);
        address owner = address(this);
        
        distributor.addProject(project);

        // Assume there's already some reward in the pool
        vm.prank(user1);
        distributor.lockTokens(1000 * 10**18, 30 days);  // This will add to the reward pool

        // Users vote
        vm.startPrank(user1);
        distributor.voteForProject(0, 50 * 10**18);
        vm.stopPrank();

        vm.startPrank(owner);
        distributor.distributeRewards();
        assertEq(eigenToken.balanceOf(project), 200 * 10**18, "Distribution failed");  // 20% of locked tokens
        vm.stopPrank();
    }
}
