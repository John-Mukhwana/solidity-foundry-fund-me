# Learning Journal: Foundry Fund Me Project

---

## July 25, 2025

### Project Setup & Initial Exploration
- Cloned the Foundry Fund Me project and explored the directory structure.
- Understood the purpose of the project: a decentralized crowdfunding contract using Foundry and Chainlink price feeds.
- Identified key files: `FundMe.sol`, `PriceConverter.sol`, and the use of Chainlink oracles.
- Removed the default GitHub Actions workflow to avoid CI errors.
- Updated the README.md to provide comprehensive project documentation, including setup, usage, and troubleshooting.

---

## July 26, 2025

### Writing and Understanding Tests
- Created and edited `test/FundMeTest.t.sol` to test contract functionality.
- Learned about Foundry's test assertions:
  - `assertEq(a, b)`: Asserts that `a == b`.
  - `assertTrue(x)`: Asserts that `x` is true.
- Understood the use of `setUp()` for initializing test state before each test.
- Discovered that private variables (like `i_owner`) require public getter functions for testing.
- Added and used `getOwner()` in `FundMe.sol` to allow owner checks in tests.
- Learned about Foundry's verbosity flags (`-v`, `-vv`, `-vvv`) for more detailed test output.
- Practiced using `vm.expectRevert()` to test for expected failures.
- Fixed typos and errors (e.g., `adress(this)` to `address(this)`, `fundeMe` to `fundMe`).
- Used `forge test --match-test testFunctionName` to run specific tests.

---


## July 27, 2025

### Advanced Testing, Deployment, and Debugging
- Added more advanced tests, including checking the price feed version and using real Chainlink price feed contract addresses.
- Used `console.log` for debugging test output and confirming values in tests.
- Learned the difference between contract addresses (used for price feeds) and wallet/public addresses.
- Understood that forking a real network (e.g., Sepolia) with `--fork-url` is required to interact with real deployed contracts in tests.
- Fixed test failures by ensuring the correct contract address and network fork are used.
- Learned to use Chainlink documentation to find the correct price feed contract address for a given network.
- Practiced using `forge test --fork-url $SEPOLIA_RPC_URL` and exporting environment variables in PowerShell.
- Fixed Solidity warnings by marking test functions as `view` when they do not modify state.
- Learned about and used `forge coverage` to check how much of the contract code is tested.
- Created a deployment script (`DeployFundMe.s.sol`) for automated contract deployment using Foundry's scripting system.
- Documented the difference between public, private, and internal variables and their impact on testing and contract interaction.
- Understood how to retrieve deployed contract addresses from deployment logs, block explorers, or Chainlink documentation.
- Updated `.env` file and learned how to load environment variables for Foundry commands.

---


## Key Takeaways
- Always match constructor arguments in tests to contract requirements.
- Use public getter functions to access private state in tests.
- Use Foundry's test flags and logging for effective debugging.
- Mark test functions as `view` if they do not modify state to avoid warnings.
- Use `forge coverage` to measure how much of your code is tested.
- Use the correct contract address (not a wallet address) for external contract calls.
- Use Chainlink documentation to find real price feed addresses for your network.
- Use `--fork-url` to fork a real network for integration tests with live contracts.
- Export environment variables in your shell or use tools like dotenv-cli to load `.env` files.
- Document every learning step for future reference and reproducibility.

---

**Happy Learning!**
