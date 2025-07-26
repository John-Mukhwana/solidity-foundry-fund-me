// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import "forge-std/Test.sol";

contract FundMeTest is Test {
    uint256 favNumber = 0;
    bool greatCourse = false;

    // This function is called before each test
    function setUp() external {
        // Initialize variables or set up the environment for tests
        favNumber = 42;
        greatCourse = true;
    }

    function testDemo() public {
        assertEq(favNumber, 42);
        assertTrue(greatCourse);
    }
}
