// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LiqMantleEigen is ERC20 {
    address public admin;

    constructor() ERC20("LiqMantleEigen", "LME") {
        admin = msg.sender; // Set the admin as the person who deploys the contract
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == admin, "Only admin can mint");
        _mint(to, amount);
    }
}
