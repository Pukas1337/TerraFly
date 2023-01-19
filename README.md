# TerraFly Smart Contracts

This repository contains the smart contracts for the TerraFly project. The contracts include:

- TerraFly: The main contract that manages the entire TerraFly system and references the required contracts discussed earlier.
- TerraFlyToken: The contract that implements the TerraFly token, which is used for carbon offsetting and rewards.
- CarbonOffsetting: A smart contract that implements the carbon offsetting mechanism. It receives offset units from users, checks the offset status, and tracks the offset units.
- Partnerships: A smart contract that stores the partnerships data. It includes the list of airlines and travel providers that are partnered with TerraFly.
- ClimateTrade: A smart contract that implements the ClimateTrade Marketplace API. It allows users to purchase carbon offsetting units from various approved carbon offsetting projects.
- TokenExchange: A smart contract that allows users to exchange their TerraFly tokens for other loyalty program miles and use them to get benefits such as airline upgrades, lounge access, premium security check lines, hotel upgrades, and many more such travel benefits.
- RadarBoxOracle: A smart contract that is an oracle for the TerraFly project, it allows for the integration of flight tracking data.
- TokenVesting: A smart contract that handles the vesting schedule of the tokens. It ensures that the tokens are locked until the vesting period is over.
- TerraFlyTest: A smart contract that enables the testing of the TerraFly system.

## Requirements
- Truffle v5.1.24
- OpenZeppelin v3.4.0
- Node v14.16.1

### Installation
- Clone the repository

## How to test
  - Clone the repository
  - Install the dependencies by running "npm install"
  - Compile the contracts by running "truffle compile"
  - Deploy the contracts to your desired network truffle migrate --network [network_name]
  - Run the tests by running "truffle test"
  - Deploy the contracts to a testnet or a mainnet using Truffle

## TerraFlyTest

The TerraFlyTest contract is a testing smart contract that allows users to test the TerraFly system before deployment. In order to use this contract, you will need to have a local development environment set up with the necessary dependencies. Once you have that set up, you can follow these steps to test the TerraFly system:

1. Compile the TerraFly contracts: Use a solidity compiler to compile the TerraFly contracts, including the TerraFly, TerraFlyToken, Partnerships, CarbonOffsetting, ClimateTrade, TokenExchange, RadarBoxOracle, TokenVesting, and TerraFlyTest contracts.

2. Deploy the contracts: Use a local blockchain client such as Ganache to deploy the contracts to a local test blockchain. Make sure to properly link the contracts as necessary.

3. Test the TerraFlyTest contract: Interact with the TerraFlyTest contract using a web3 interface such as Remix or Truffle. The TerraFlyTest contract includes various test functions that allow you to test various features of the TerraFly system, such as purchasing carbon offset units, exchanging tokens for travel benefits, and more.

4. Check the results: Observe the results of the tests in the blockchain client and web3 interface to ensure that the system is functioning as expected.

5. Repeat as necessary: Make any necessary changes to the contracts and repeat the testing process until the TerraFly system is functioning as desired.

It's important to note that the TokenVesting contract will be used to handle the vesting schedule of the tokens, it ensures that the tokens are locked until the vesting period is over.

## Important note:

The contracts are being tested on Rinkeby and Ropsten testnets and have not been audited yet. Use them at your own risk.

## Contribution:

We welcome contributions to the project. If you have any suggestions or bug reports, please open an issue or a pull request.
