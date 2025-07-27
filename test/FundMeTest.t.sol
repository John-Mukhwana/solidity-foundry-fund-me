// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundeMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    // This function is called before each test
    function setUp() external {
        // Initialize variables or set up the environment for tests
        fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
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

    // Added this to fix the testing error whereversion 4 was
    function testLogVersion() public {
        uint256 version = fundMe.getVersion();
        console.log("Aggregator version:", version);
    }

    function testPriceFeedVersionIsAccurate() public {
        uint256 version = fundMe.getVersion();
        console.log("Price Feed Version:", version);
        assertEq(version, 4); // Assuming the expected version is 4
    }
}
