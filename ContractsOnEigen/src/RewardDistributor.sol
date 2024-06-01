// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RewardDistributor is Ownable {
    IERC20 public eigenToken;
    ERC20 public lasticToken;
    uint256 public rewardPool;

    struct Lock {
        uint256 amount;
        uint256 unlockTime;
    }

    mapping(address => Lock[]) public locks;
    mapping(address => uint256) public votes;
    address[] public projects;

    constructor(address _eigenToken) {
        eigenToken = IERC20(_eigenToken);
        lasticToken = new ERC20("LASTIC", "LST");
    }

    function lockTokens(uint256 amount, uint256 time) external {
        require(eigenToken.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        uint256 lockDuration = block.timestamp + time;
        uint256 lasticAmount = calculateLasticAmount(amount, time);

        locks[msg.sender].push(Lock({
            amount: amount,
            unlockTime: lockDuration
        }));

        lasticToken.mint(msg.sender, lasticAmount);
    }

    function unlockTokens() external {
        uint256 totalAmount = 0;
        uint256 claimable = 0;

        for (uint i = 0; i < locks[msg.sender].length; i++) {
            Lock storage lock = locks[msg.sender][i];
            if (block.timestamp >= lock.unlockTime) {
                totalAmount += lock.amount;
                delete locks[msg.sender][i];
            }
        }

        if (totalAmount > 0) {
            claimable = (totalAmount * 80) / 100;
            rewardPool += (totalAmount * 20) / 100;
            eigenToken.transfer(msg.sender, claimable);
        }
    }

    function calculateLasticAmount(uint256 amount, uint256 time) internal pure returns (uint256) {
        return (amount * time) / (30 days);  // Simplified calculation
    }

    function voteForProject(uint256 projectIndex, uint256 amount) public {
        require(lasticToken.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        votes[projects[projectIndex]] += amount;
    }

    function addProject(address project) public onlyOwner {
        projects.push(project);
    }

    function distributeRewards() public onlyOwner {
        uint256 totalVotes = 0;
        for (uint i = 0; i < projects.length; i++) {
            totalVotes += votes[projects[i]];
        }

        for (uint i = 0; i < projects.length; i++) {
            uint256 projectReward = (rewardPool * votes[projects[i]]) / totalVotes;
            eigenToken.transfer(projects[i], projectReward);
        }

        rewardPool = 0;  // Reset the reward pool after distribution
    }
}
