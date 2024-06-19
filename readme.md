# SavingsBank Smart Contract

This smart contract simulates a basic savings bank where users can deposit, withdraw, and check their balances. It uses Solidity version 0.8.0 and adheres to the MIT license.

## Overview

The `SavingsBank` contract enables users to interact with a simple banking system on the blockchain. Users can deposit Ether into their account, withdraw funds, and check their current balance. Additionally, the contract owner has the ability to withdraw funds from the contract.

## Key Features

- **Deposits**: Users can deposit Ether into their account using the `deposit()` function.
- **Withdrawals**: Users can withdraw their deposited Ether using the `withdraw()` function. The contract owner can also withdraw funds using the `ownerWithdraw()` function.
- **Balance Inquiry**: Users can inquire about their current balance using the `checkBalance()` function.
- **Fallback and Receive Functions**: The contract includes a fallback function to handle incoming Ether transactions and a receive function for convenience.

## Constructor

- Initializes the contract with the sender of the transaction as the owner.

## Functions

### Deposit

Allows users to deposit Ether into their account. The deposit amount must be greater than zero.

