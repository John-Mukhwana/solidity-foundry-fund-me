// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundeMe.sol";

contract DeployFundMe {
    FundMe public fundMe;

    constructor() {
        fundMe = new FundMe(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
    }
}
