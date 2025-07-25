# Foundry Fund Me

A decentralized crowdfunding smart contract built with Foundry that allows users to fund projects with ETH. The contract uses Chainlink price feeds to ensure a minimum USD funding threshold.

## 🚀 Features

- **Decentralized Funding**: Accept ETH donations with USD minimum threshold
- **Chainlink Integration**: Real-time ETH/USD price conversion using Chainlink oracles
- **Owner Controls**: Only contract owner can withdraw funds
- **Gas Optimized**: Efficient storage patterns and custom errors
- **Foundry Framework**: Built with modern Solidity development tools

## 📁 Project Structure

```
foundry-fund-me/
├── src/
│   ├── FundMe.sol          # Main funding contract
│   └── PriceConverter.sol  # Chainlink price conversion library
├── lib/
│   ├── forge-std/          # Foundry standard library
│   └── chainlink-brownie-contracts/  # Chainlink contracts
├── test/                   # Test files (to be implemented)
├── foundry.toml           # Foundry configuration
└── README.md
```

## 🛠 Tech Stack

- **Solidity**: ^0.8.19
- **Foundry**: Development framework
- **Chainlink**: Price feed oracles
- **OpenZeppelin**: Security patterns

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- [Git](https://git-scm.com/)
- [Foundry](https://book.getfoundry.sh/getting-started/installation)

### Install Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/John-Mukhwana/solidity-foundry-fund-me.git
cd solidity-foundry-fund-me
```

### 2. Install Dependencies

```bash
forge install
```

### 3. Update Git Submodules (if needed)

```bash
git submodule update --init --recursive
```

## 🔧 Configuration

### Environment Setup

Create a `.env` file in the root directory:

```bash
# Network RPC URLs
SEPOLIA_RPC_URL=your_sepolia_rpc_url
MAINNET_RPC_URL=your_mainnet_rpc_url

# Private Keys (Never commit these!)
PRIVATE_KEY=your_private_key

# Etherscan API Key
ETHERSCAN_API_KEY=your_etherscan_api_key
```

### Foundry Configuration

The `foundry.toml` file contains:

```toml
[profile.default]
src = "src"
out = "out"
remappings = ['@chainlink/contracts/=lib/chainlink-brownie-contracts/contracts/']
```

## 📖 Smart Contract Details

### FundMe.sol

The main contract with the following features:

- **Minimum funding**: $5 USD equivalent in ETH
- **Price feed integration**: Uses Chainlink AggregatorV3Interface
- **Funding tracking**: Maps addresses to funding amounts
- **Withdrawal mechanism**: Only owner can withdraw all funds

### PriceConverter.sol

A library providing:

- `getPrice()`: Gets current ETH/USD price from Chainlink
- `getConversionRate()`: Converts ETH amount to USD equivalent

### Key Functions

```solidity
// Fund the contract (payable)
function fund() public payable

// Withdraw all funds (owner only)
function withdraw() public onlyOwner

// Get funded amount for an address
function getAddressToAmountFunded(address fundingAddress) external view returns (uint256)

// Get list of funders
function getFunder(uint256 index) external view returns (address)
```

## 🔨 Development Commands

### Build

Compile the smart contracts:

```bash
forge build
```

### Test

Run the test suite:

```bash
forge test
```

Run tests with verbose output:

```bash
forge test -vvv
```

### Format Code

Format Solidity files:

```bash
forge fmt
```

### Gas Snapshots

Generate gas usage snapshots:

```bash
forge snapshot
```

### Coverage

Check test coverage:

```bash
forge coverage
```

## 🌐 Deployment

### Local Deployment (Anvil)

1. Start local blockchain:

```bash
anvil
```

2. Deploy to local network:

```bash
# Deploy with Sepolia ETH/USD price feed address
forge create --rpc-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 src/FundMe.sol:FundMe --constructor-args 0x694AA1769357215DE4FAC081bf1f309aDC325306
```

### Testnet Deployment (Sepolia)

```bash
# Deploy to Sepolia testnet
forge create --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY src/FundMe.sol:FundMe --constructor-args 0x694AA1769357215DE4FAC081bf1f309aDC325306 --verify --etherscan-api-key $ETHERSCAN_API_KEY
```

## 🔗 Chainlink Price Feed Addresses

### Sepolia Testnet
- **ETH/USD**: `0x694AA1769357215DE4FAC081bf1f309aDC325306`

### Mainnet
- **ETH/USD**: `0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419`

## 🧪 Testing

### Writing Tests

Create test files in the `test/` directory:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    
    function setUp() public {
        // Setup test environment
    }
    
    function testMinimumDollarIsFive() public {
        // Test implementation
    }
}
```

### Running Specific Tests

```bash
# Run specific test file
forge test --match-path test/FundMeTest.t.sol

# Run specific test function
forge test --match-test testMinimumDollarIsFive
```

## 🔐 Security Considerations

- **Access Control**: Only owner can withdraw funds
- **Custom Errors**: Gas-efficient error handling
- **Price Feed Validation**: Chainlink oracle integration
- **Reentrancy Protection**: Consider implementing ReentrancyGuard for production
- **Input Validation**: Minimum funding requirements enforced

## 🐛 Troubleshooting

### Common Issues

1. **Compilation errors**: Ensure correct Solidity version (0.8.19)
2. **Missing dependencies**: Run `forge install` to install libraries
3. **RPC connection issues**: Check your RPC URL in `.env` file
4. **Gas estimation errors**: Ensure sufficient ETH for gas fees

### Dependency Management

Update dependencies:

```bash
forge update
```

Remove and reinstall dependencies:

```bash
rm -rf lib/
forge install
```

## 📚 Additional Resources

- [Foundry Documentation](https://book.getfoundry.sh/)
- [Chainlink Documentation](https://docs.chain.link/)
- [Solidity Documentation](https://docs.soliditylang.org/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Patrick Collins](https://github.com/PatrickAlphaC) for the foundational course
- [Chainlink](https://chain.link/) for reliable price feeds
- [Foundry](https://github.com/foundry-rs/foundry) for the amazing development framework

## 📞 Support

If you have any questions or need help:

- Create an issue in this repository
- Check the [Foundry discussions](https://github.com/foundry-rs/foundry/discussions)
- Join the [Chainlink Discord](https://discord.gg/chainlink)

---

**Happy Coding! 🎉**
