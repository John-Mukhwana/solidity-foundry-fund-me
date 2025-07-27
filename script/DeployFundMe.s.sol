// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundeMe.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        vm.startBroadcast();
        FundMe fundMe = new FundMe(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
        vm.stopBroadcast();
        return fundMe;
    }
}
