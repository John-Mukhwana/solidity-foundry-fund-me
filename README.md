# Foundry Fund Me

A decentralized crowdfunding smart contract built with Foundry that allows users to fund projects with ETH. The contract uses Chainlink price feeds to ensure a minimum USD funding threshold.

## 🚀 Features

- **Decentralized Funding**: Accept ETH donations with USD minimum threshold
- **Chainlink Integration**: Real-time ETH/USD price conversion using Chainlink oracles
- **Owner Controls**: Only contract owner can withdraw funds
- **Gas Optimized**: Efficient storage patterns and custom errors
- **Foundry Framework**: Built with modern Solidity development tools



## 🛠️ Useful Commands & Options Learned

- `forge test --match-test <testName>`: Run a specific test function by name.
- `forge test --match-path <path/to/testFile.t.sol>`: Run tests in a specific test file.
- `forge test -v`, `-vv`, `-vvv`: Increase test output verbosity for debugging.
- `forge test --fork-url $SEPOLIA_RPC_URL`: Run tests on a forked Sepolia network (enables interaction with real deployed contracts).
- `forge test --fork-url $MAINNET_RPC_URL`: Run tests on a forked Ethereum mainnet.
- `forge coverage`: Generate a test coverage report to see which lines of code are tested.
- `forge test --fork-url $env:SEPOLIA_RPC_URL`: (PowerShell) Use environment variable for forking.
- `dotenv -e .env -- forge test ...`: Use dotenv-cli to load environment variables from `.env` file.
- `console.log(...)`: Print values to the test output for debugging (from `forge-std`).
- `vm.expectRevert()`: Expect a revert in the next transaction (for negative test cases).
- `export VAR=value` (Linux/macOS) or `$env:VAR=\"value\"` (PowerShell): Set environment variables for use in Foundry commands.
- Marking test functions as `view`: Suppress Solidity warnings when the function does not modify state.

## 🧩 Architectural Patterns & Best Practices

- **Configuration Pattern:** Used a `HelperConfig` contract to manage external contract addresses (like Chainlink price feeds) for different networks (mainnet, testnets, local). This avoids hardcoding and makes the codebase network-agnostic.
- **Mock Contracts:** Automatically deploys a mock price feed on local Anvil chains for reliable testing.
- **Environment Variables:** Store sensitive data and RPC URLs in a `.env` file and load them into your shell for secure, flexible configuration.
- **Public Struct Getter Usage:** When accessing a public struct, call the getter as a function and then access its members (e.g., `helperConfig.activeNetworkConfig().priceFeed`).
- **Test Function Mutability:** Mark test functions as `view` if they do not modify state to avoid compiler warnings.
- **Logging & Debugging:** Use `console.log` in tests and scripts for debugging contract state and addresses.

## 📝 Troubleshooting & Common Errors

- **EvmError: Revert:** Usually caused by using an incorrect or non-existent contract address on the forked network.
- **invalid provider URL:** Caused by passing the literal string instead of the environment variable value. Always use `$SEPOLIA_RPC_URL` or `$env:SEPOLIA_RPC_URL`.
- **Member not found or not visible:** When accessing struct members from a public getter, first call the getter, then access the member.
- **msg.sender in Scripts:** When deploying via `vm.startBroadcast`, `msg.sender` in the constructor is set to the broadcast account, not the script or test contract.


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

## 🧪 Advanced Testing & Gas Optimization

### Gas Snapshots & Performance Analysis

**Create and manage gas snapshots:**
```bash
# Create gas snapshot for all tests
forge snapshot

# Create snapshot for specific test
forge snapshot --mt testWithdrawFromMultipleFunders

# Compare current gas usage with snapshot
forge snapshot --diff

# Check if gas usage matches snapshot (CI/CD)
forge snapshot --check

# Generate detailed gas report
forge test --gas-report
```

**Gas snapshot files:**
- `.gas-snapshot` - Contains gas usage for each test function
- Used for regression testing and optimization tracking

### Storage Optimization Patterns

**1. Variable Packing:**
```solidity
// ❌ Inefficient (uses 3 storage slots)
uint256 value1;    // Slot 0 (32 bytes)
uint128 value2;    // Slot 1 (16 bytes, wastes 16 bytes)
uint128 value3;    // Slot 2 (16 bytes, wastes 16 bytes)

// ✅ Efficient (uses 2 storage slots)
uint256 value1;    // Slot 0 (32 bytes)
uint128 value2;    // Slot 1 (16 bytes)
uint128 value3;    // Slot 1 (16 bytes) - packed together!
```

**2. Memory vs Storage Optimization:**
```solidity
// Gas-optimized withdrawal using memory array
function cheaperWithdraw() public onlyOwner {
    address[] memory funders = s_funders;  // Copy to memory once
    for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
        address funder = funders[funderIndex];
        s_addressToAmountFunded[funder] = 0;
    }
    s_funders = new address[](0);
    (bool success,) = i_owner.call{value: address(this).balance}("");
    require(success);
}
```

### Advanced Testing Patterns

**1. Test Modifiers for Setup:**
```solidity
modifier funded() {
    vm.prank(USER);
    fundMe.fund{value: SEND_VALUE}();
    _;
}

function testOnlyOwnerCanWithdraw() public funded {
    vm.expectRevert();
    vm.prank(USER);
    fundMe.withdraw();
}
```
**Purpose:** Reusable test setup that automatically funds the contract before test execution.

**2. Multiple Funder Testing:**
```solidity
function testWithdrawFromMultipleFunders() public funded {
    uint160 numberOfFunders = 10;
    uint160 startingFunderIndex = 1;
    
    for (uint160 i = startingFunderIndex; i < numberOfFunders + startingFunderIndex; i++) {
        hoax(address(i), SEND_VALUE);  // prank + deal combined
        fundMe.fund{value: SEND_VALUE}();
    }
    
    vm.startPrank(fundMe.getOwner());
    fundMe.withdraw();
    vm.stopPrank();
}
```
**Purpose:** Tests contract behavior with multiple funders to ensure proper state management.

**3. Gas Comparison Testing:**
```solidity
function testWithdrawFromMultipleFundersCheaper() public funded {
    // Setup multiple funders (same as above)
    vm.startPrank(fundMe.getOwner());
    fundMe.cheaperWithdraw();  // Test optimized version
    vm.stopPrank();
}
```
**Purpose:** Compare gas usage between standard and optimized contract functions.

### Advanced Foundry Cheatcodes

**Address Generation:**
```solidity
address USER = makeAddr("user");  // Deterministic labeled address
```

**Combined Operations:**
```solidity
hoax(address(1), SEND_VALUE);  // vm.prank() + vm.deal() in one call
```

**Extended Pranking:**
```solidity
// Single call
vm.prank(USER);
fundMe.fund{value: SEND_VALUE}();

// Multiple calls
vm.startPrank(fundMe.getOwner());
fundMe.withdraw();
fundMe.someOtherFunction();
vm.stopPrank();
```

### AAA Testing Pattern Implementation

**Structure every test with:**
```solidity
function testExample() public {
    // 🔧 ARRANGE - Set up initial conditions
    uint256 startingBalance = address(fundMe).balance;
    
    // ⚡ ACT - Execute the behavior being tested
    vm.prank(USER);
    fundMe.fund{value: SEND_VALUE}();
    
    // ✅ ASSERT - Verify the results
    assertEq(address(fundMe).balance, startingBalance + SEND_VALUE);
}
```

### Writing Tests

Create comprehensive test files in the `test/` directory:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 10e18;
    uint256 constant STARTING_BALANCE = 100 ether;
    
    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }
    
    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }
    
    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert();
        fundMe.fund();
    }
}
```

### Running Specific Tests

```bash
# Run specific test file
forge test --match-path test/FundMeTest.t.sol

# Run specific test function
forge test --match-test testMinimumDollarIsFive

# Run with verbosity for debugging
forge test --match-test testWithdrawFromMultipleFunders -vvv

# Run tests with gas reporting
forge test --gas-report

# Run tests on forked network
forge test --fork-url $SEPOLIA_RPC_URL
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


## 🧑‍💻 Lessons Learned & Best Practices

- Always use the correct contract address (not a wallet address) for external contract calls, especially for Chainlink price feeds.
- When testing contracts that interact with live oracles, use `--fork-url` to fork a real network (e.g., Sepolia) so the contract exists at the given address.
- Mark test functions as `view` if they do not modify state to avoid Solidity warnings.
- Use public getter functions to access private or internal state variables in tests.
- Use Foundry's test flags (`-v`, `-vv`, `-vvv`) and `console.log` for effective debugging.
- Use `forge coverage` to measure how much of your code is tested.
- Export environment variables in your shell or use tools like dotenv-cli to load `.env` files for Foundry commands.
- Use Chainlink documentation to find real price feed addresses for your network.
- Document every learning step and resolved error for future reference and reproducibility.

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
