// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;


import {Test,console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundeMe.sol";

contract FundMeTest is Test {

   FundMe fundMe;

    // This function is called before each test
    function setUp() external {
        // Initialize variables or set up the environment for tests
        fundMe = new FundMe( 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419 );
        console.log("This will get printed first!");
    }

       function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }
}
