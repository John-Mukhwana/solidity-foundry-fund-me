// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundeMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    address USER =makeAddr("user")

    // This function is called before each test
    function setUp() external {
        // Initialize variables or set up the environment for tests
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        console.log("This will get printed first!");
    }

    function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        console.log(fundMe.getOwner());
        console.log(msg.sender);
        assertEq(fundMe.getOwner(), msg.sender);
    }

    // Added this to fix the testing error whereversion 4 was
    function testLogVersion() public {
        uint256 version = fundMe.getVersion();
        console.log("Aggregator version:", version);
    }

    // function testPriceFeedVersionIsAccurate() public {
    //     uint256 version = fundMe.getVersion();
    //     console.log("Price Feed Version:", version);
    //     assertEq(version, 4); // Assuming the expected version is 4
    // }


      function testPriceFeedVersionIsAccurate() public {
        if (block.chainid == 11155111) {
            uint256 version = fundMe.getVersion();
            assertEq(version, 4);
        } else if (block.chainid == 1) {
            uint256 version = fundMe.getVersion();
            assertEq(version, 6);
        }
  } 

  function testFundFailsWihtoutEnoughEth() public{
    vm.expectRevert(); //hey, the next line should revert
    fundMe.fund(); // This should revert if not enough ETH is sent
  }

  function testFundUpdatesFundedDataStructure() public{
    vm.prank(USER); // the nect Tx  will be send by
    fundMe.fund{value: 10e18}();
    uint256 fundedAmount = fundMe.getAddressToAmountFunded(address(this));
    assertEq(fundedAmount, 10e18); // Check if the funded amount is correctly updated
  }
}
