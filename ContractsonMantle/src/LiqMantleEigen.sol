// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IOracle {
    function getContribution(address user) external view returns (uint256);
}

contract LiqMantleEigen is ERC20 {
    address public admin;
    uint256 public lastMintBlock;
    uint256 public totalMintedThisPeriod;
    IOracle public oracle;

    mapping(address => uint256) public userContributions;
    address[] public registeredUsers;

    // Constants for the minting restrictions
    uint256 private constant BLOCKS_BETWEEN_MINTS = 100;
    uint256 private constant MAX_MINT_AMOUNT_PER_PERIOD = 100;

    constructor(address oracleAddress) ERC20("LiqMantleEigen", "LME") {
        admin = msg.sender;
        lastMintBlock = block.number;
        totalMintedThisPeriod = 0;
        oracle = IOracle(oracleAddress);
    }

    function registerUser() public {
        // Anyone can register as a user
        uint256 contribution = oracle.getContribution(msg.sender);
        userContributions[msg.sender] = contribution;
        registeredUsers.push(msg.sender);
    }

    function mintAndDistributeTokens() public {
        require(msg.sender == admin, "Only admin can distribute tokens");
        require(block.number >= lastMintBlock + BLOCKS_BETWEEN_MINTS, "Minting not yet available");
        require(totalMintedThisPeriod == 0, "Tokens have already been minted for this period");

        uint256 totalContributions = sumContributions();
        require(totalContributions > 0, "Total contributions must be greater than zero");

        uint256 remainingTokens = MAX_MINT_AMOUNT_PER_PERIOD;
        for (uint i = 0; i < registeredUsers.length; i++) {
            address user = registeredUsers[i];
            uint256 userTokens = (userContributions[user] * MAX_MINT_AMOUNT_PER_PERIOD) / totalContributions;

            // Ensure not to exceed the max mint amount
            userTokens = (remainingTokens > userTokens) ? userTokens : remainingTokens;
            _mint(user, userTokens);
            remainingTokens -= userTokens;
        }

        assert(remainingTokens >= 0);  // Ensure no overflow has occurred
        lastMintBlock = block.number;
        totalMintedThisPeriod = 0;  // Reset for the next period
    }


    function sumContributions() private view returns (uint256) {
        uint256 total = 0;
        for (uint i = 0; i < registeredUsers.length; i++) {
            total += userContributions[registeredUsers[i]];
        }
        return total;
    }

    function updateContributions() public {
        require(msg.sender == admin, "Only admin can update contributions");
        for (uint i = 0; i < registeredUsers.length; i++) {
            address user = registeredUsers[i];
            userContributions[user] = oracle.getContribution(user);
        }
    }
}
