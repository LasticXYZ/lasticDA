// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VotingToken is ERC20 {
    constructor() ERC20("Eigen Voting Token", "EVT") {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

contract RewardDistributor is Ownable {
    IERC20 public eigenToken;
    VotingToken public eigVotTok;
    uint256 public rewardPool;

    struct Lock {
        uint256 amount;
        uint256 unlockTime;
    }

    mapping(address => Lock[]) public locks;
    mapping(address => uint256) public votes;
    address[] public projects;

    constructor(address _eigenToken) Ownable(msg.sender) {
        eigenToken = IERC20(_eigenToken);
        eigVotTok = new VotingToken();
    }

    function lockTokens(uint256 amount, uint256 time) external {
        require(eigenToken.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        uint256 lockDuration = block.timestamp + time;
        uint256 eigenVotAmount = calculateVotingAmount(amount, time);

        locks[msg.sender].push(Lock({
            amount: amount,
            unlockTime: lockDuration
        }));

        eigVotTok.mint(msg.sender, eigenVotAmount);
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

    function calculateVotingAmount(uint256 amount, uint256 time) internal pure returns (uint256) {
        return (amount * time) / (30 days);  // Simplified calculation
    }

    function voteForProject(uint256 projectIndex, uint256 amount) public {
        require(eigVotTok.transferFrom(msg.sender, address(this), amount), "Transfer failed");
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
