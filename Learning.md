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

### Advanced Testing & Debugging
- Added more advanced tests, including checking the price feed version.
- Used `console.log` for debugging test output.
- Learned about constructor arguments and the need to pass a mock or real price feed address when deploying contracts in tests.
- Understood why some code from tutorials may differ (e.g., variable visibility) and how to adapt it for your own codebase.

---

## Key Takeaways
- Always match constructor arguments in tests to contract requirements.
- Use public getter functions to access private state in tests.
- Use Foundry's test flags and logging for effective debugging.
- Document every learning step for future reference and reproducibility.

---

**Happy Learning!**
