// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 10e18; // 10 ETH in wei
    uint256 constant STARTING_BALANCE = 100 ether; // Starting balance for the user

    // This function is called before each test
    function setUp() external {
        // Initialize variables or set up the environment for tests
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        console.log("This will get printed first!");
        vm.deal(USER, STARTING_BALANCE); // Give USER a starting balance
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

    function testFundFailsWihtoutEnoughEth() public {
        vm.expectRevert(); //hey, the next line should revert
        fundMe.fund(); // This should revert if not enough ETH is sent
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER); // the next Tx will be sent by user
        fundMe.fund{value: SEND_VALUE}();
        uint256 fundedAmount = fundMe.getAddressToAmountFunded(address(USER));
        assertEq(fundedAmount, SEND_VALUE); // Check if the funded amount is correctly updated
    }

    function testAddFunderToArrayOfFunders() public {
        vm.prank(USER); // the next Tx will be sent by user
        fundMe.fund{value: SEND_VALUE}();
        address funder = fundMe.getFunder(0); // Get the first funder
        assertEq(funder, USER); // Check if the funder is correctly added to the
    }

    modifier funded() {
        vm.prank(USER); // the next Tx will be sent by user
        fundMe.fund{value: SEND_VALUE}();
        _;
    }

    function testOnlyOwnerCanWithdraw() public funded {
        vm.prank(USER); // the next Tx will be sent by user
        vm.expectRevert(); // Expect revert for non-owner withdrawal
        fundMe.withdraw();
    }

    function testWithdrawWithASingleFunder() public funded {
        //Arrange
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;
        //Act
        vm.prank(fundMe.getOwner()); // The next Tx will be sent by the owner
        fundMe.withdraw();
        //Assert
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingFundMeBalance = address(fundMe).balance;
        assertEq(endingFundMeBalance, 0); // Check if the contract balance is zero
        assertEq(
            startingFundMeBalance + startingOwnerBalance,
            endingOwnerBalance
        ); // Check if the owner's balance is updated correctly
    }

    function testWithdrawFromMultipleFunders() public funded {
        // Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;
        for (
            uint160 i = startingFunderIndex;
            i < numberOfFunders + startingFunderIndex;
            i++
        ) {
            // we get hoax from stdcheats
            // prank + deal
            hoax(address(i), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }
        // Arrange
        uint256 startingFundMeBalance = address(fundMe).balance;
        uint256 startingOwnerBalance = fundMe.getOwner().balance;

        //Act
        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();

        // Assert
        assert(address(fundMe).balance == 0);
        assert(
            startingFundMeBalance + startingOwnerBalance ==
                fundMe.getOwner().balance
        );
        assert(
            (numberOfFunders + 1) * SEND_VALUE ==
                fundMe.getOwner().balance - startingOwnerBalance
        );
    }

    function testWithdrawFromMultipleFundersCheaper() public funded {
        // Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;
        for (
            uint160 i = startingFunderIndex;
            i < numberOfFunders + startingFunderIndex;
            i++
        ) {
            // we get hoax from stdcheats
            // prank + deal
            hoax(address(i), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }
        // Arrange
        uint256 startingFundMeBalance = address(fundMe).balance;
        uint256 startingOwnerBalance = fundMe.getOwner().balance;

        //Act
        vm.startPrank(fundMe.getOwner());
        fundMe.cheaperWithdraw();

        // Assert
        assert(address(fundMe).balance == 0);
        assert(
            startingFundMeBalance + startingOwnerBalance ==
                fundMe.getOwner().balance
        );
        assert(
            (numberOfFunders + 1) * SEND_VALUE ==
                fundMe.getOwner().balance - startingOwnerBalance
        );
    }
}
