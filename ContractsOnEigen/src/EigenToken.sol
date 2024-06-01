// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EigenToken is ERC20 {
    struct Lock {
        uint256 amount;
        uint256 unlockTime;
    }

    mapping(address => Lock[]) public locks;

    constructor() ERC20("EigenToken", "EIGEN") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function lockTokens(uint256 amount, uint256 time) external {
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance to lock");

        _transfer(msg.sender, address(this), amount);
        locks[msg.sender].push(Lock({
            amount: amount,
            unlockTime: block.timestamp + time
        }));
    }

    function unlockTokens() external {
        Lock[] storage userLocks = locks[msg.sender];
        uint256 totalUnlocked = 0;
        bool unlocked = false;

        for (uint i = 0; i < userLocks.length; i++) {
            if (block.timestamp >= userLocks[i].unlockTime && userLocks[i].amount > 0) {
                _transfer(address(this), msg.sender, userLocks[i].amount);
                totalUnlocked += userLocks[i].amount;
                userLocks[i].amount = 0; // Mark as unlocked
                unlocked = true;
            }
        }

        if (!unlocked) {
            revert("Tokens are still locked.");
        }
    }


    // Accessor for testing purposes
    function getLockForUser(address user, uint256 index) public view returns (uint256 amount, uint256 unlockTime) {
        require(index < locks[user].length, "Index out of bounds");
        Lock storage lock = locks[user][index];
        return (lock.amount, lock.unlockTime);
    }
}
