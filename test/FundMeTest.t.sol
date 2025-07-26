// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundeMe.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    // This function is called before each test
    function setUp() external {
        // Initialize variables or set up the environment for tests
        fundMe = new FundMe(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
        console.log("This will get printed first!");
    }

    function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        console.log(fundMe.getOwner());
        console.log(msg.sender);
        assertEq(fundMe.getOwner(), address(this));
    }
}
