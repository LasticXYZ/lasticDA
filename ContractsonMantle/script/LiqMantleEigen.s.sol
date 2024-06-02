// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

contract MyContract {
    // Your contract code here
}

contract LiqMantleEigen is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        MyContract myContract = new MyContract();
        console.log("Contract deployed at:", address(myContract));

        vm.stopBroadcast();
    }
}
