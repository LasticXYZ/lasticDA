// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OracleMock {
    mapping(address => uint256) public contributions;

    function setContribution(address user, uint256 amount) public {
        contributions[user] = amount;
    }

    function getContribution(address user) external view returns (uint256) {
        return contributions[user];
    }
}
