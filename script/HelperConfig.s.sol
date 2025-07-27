// SPDX-License-Identifier: MIT

//1 .Deploy mocks when we are on a local anvil chain
//2.Keep track of the price feed address across different chains

pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";

contract HelperConfig{
//If we are on a local anvil,we deploy mocks
// otherwise ,gran the existing adress from the live network

   struct NetworkConfig {
       address priceFeed;
   }

   
   function getSepoliaEthConfig() public pure returns (NetworkConfig memory){
         NetworkConfig memory sepoliaConfig = NetworkConfig({
              priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306 // Sepolia ETH/USD price feed address
         });
         return sepoliaConfig;

   }

   function getAnvilEthConfig() public pure returns(NetworkConfig memory){

   }

}