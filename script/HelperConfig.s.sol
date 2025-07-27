// SPDX-License-Identifier: MIT

//1 .Deploy mocks when we are on a local anvil chain
//2.Keep track of the price feed address across different chains

pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script{
    //If we are on a local anvil,we deploy mocks
    // otherwise ,grab the existing address from the live network

    NetworkConfig public activeNetworkConfig;

    unint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_ANSWER = 2000e8; // 2000 USD with 8 decimals

    struct NetworkConfig {
        address priceFeed;
    }

    constructor() {
        if (block.chainid == 11155111) {
            // Sepolia chain ID
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 1) {
            activeNetworkConfig = getMainnetEthConfig();
        } else {
            activeNetworkConfig = getAnvilEthConfig(); // Default to Anvil for other networks
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306 // Sepolia ETH/USD price feed address
        });
        return sepoliaConfig;
    }

    function getMainnetEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory mainnetConfig = NetworkConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419 // Mainnet ETH/USD price feed address
        });
        return mainnetConfig;
    }

    function getAnvilEthConfig() public  returns (NetworkConfig memory) {
        //1.deploy mocks when we are on a local anvil chain

        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_ANSWER); // 2000 USD with 8 decimals
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed) // Use the mock price feed address
        });
        return anvilConfig;
    }
}
