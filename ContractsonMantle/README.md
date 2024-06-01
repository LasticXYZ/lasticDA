# LiqMantleEigen ERC-20 Token

## Overview
LiqMantleEigen (LME) is an ERC-20 token implemented on the Ethereum blockchain, designed to support controlled minting and equitable distribution. The token minting is regulated by an administrator (bot account), which ensures that token distribution is based on user contributions recorded in external contracts.

## Features
- **Controlled Minting**: Minting of tokens can only be performed by the admin account, ensuring centralized control over token issuance.
- **Contribution-Based Distribution**: Tokens are distributed among users based on the contributions they have made, as tracked by an external contract and verified via an oracle.
- **Registration and Contribution Tracking**: A registration function allows users to register themselves. Upon registration, their contribution amounts are fetched from an oracle, which directly influences the amount of tokens they receive during distribution events.

## Functionality
- **Register User**: Any user can self-register via the `registerUser()` function, which records their contribution amount from an oracle.
- **Mint and Distribate Tokens**: Controlled by the admin (bot account), this function is triggered after every 100 blocks. It calculates the distribution of a maximum of 100 tokens based on the users' recorded contributions.
- **Update Contributions**: The admin can update user contributions based on the latest data from the oracle.

## Minting Conditions
- Tokens are minted and distributed only if `block.number` is at least 100 blocks higher than during the last minting event.
- The total amount of tokens minted in any given period is capped at 100 tokens.
- Each minting phase checks that no tokens have been previously minted within the current period, ensuring compliance with the minting restrictions.

## Interaction with Oracles
The smart contract interacts with an oracle to fetch the real-time contributions of users. This ensures that the token distribution is always based on the most current and accurate data.

## Getting Started - Frontend
To interact with the LiqMantleEigen contract:
1. Ensure you have a compatible Ethereum wallet.
2. Connect to the contract through a supported interface, such as Remix or a custom dApp interface.
3. To register, call the `registerUser()` function.
4. For admins, ensure you periodically call `updateContributions()` to refresh the contribution data before initiating token distribution.

## Potential Improvements
- Integration of a decentralized governance model for admin tasks.
- Implementation of a gas optimization strategy for functions involving numerous state changes.
- Potential changes for a more 


## Get Started - Backend

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
