// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        //Before startBroadcast -> Not a real transaction TX
        HelperConfig helperConfig = new HelperConfig();

    address ethUsdPriceFeed = helperConfig.getConfigByChainId(block.chainid).priceFeed;

        console.log("ETH/USD Price Feed Address:", ethUsdPriceFeed);
        // after startBroadcast -> A real transaction TX
        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        vm.stopBroadcast();
        return fundMe;
    }
}
