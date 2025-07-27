// SPDX-License-Identifier: MIT

//1 .Deploy mocks when we are on a local anvil chain
//2.Keep track of the price feed address across different chains

pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";

contract HelperConfig{
//If we are on a local anvil,we deploy mocks
// otherwise ,grab the existing address from the live network

   NetworkConfig public activeNetworkConfig;

   struct NetworkConfig {
       address priceFeed;
   }
 
  constructor() {
       if (block.chainid == 11155111) { // Sepolia chain ID
           activeNetworkConfig = getSepoliaEthConfig();
       } else if (block.chainid == 1) {
           activeNetworkConfig = getAnvilEthConfig();
       } else {
           activeNetworkConfig = getAnvilEthConfig(); // Default to Anvil for other networks
       }
   }
   
   function getSepoliaEthConfig() public pure returns (NetworkConfig memory){
         NetworkConfig memory sepoliaConfig = NetworkConfig({
              priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306 // Sepolia ETH/USD price feed address
         });
         return sepoliaConfig;

   }

   function getMainnetEthConfig() public pure returns (NetworkConfig memory){
         NetworkConfig memory mainnetConfig = NetworkConfig({
              priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419 // Mainnet ETH/USD price feed address
         });
         return mainnetConfig;
   }

   function getAnvilEthConfig() public pure returns(NetworkConfig memory){

   }

}