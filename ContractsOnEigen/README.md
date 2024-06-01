## TODO

Have to find the EigenLayer token that is currently locked, take that and remove the locked functionality. 


There is another smart contract that calls the sample Mock eigen smart contract.

It let's the user keep 80% of the rewards from the lock in contract and 20% is not claimable and can go into rewards for other companies. It also allows also users to lock for different durations, and depending on how long you lock the tokens you get a proportionate amount of voting tokens let's call them "LASTIC" tokens. With those tokens they can vote which project gets those 20% of non claimable rewards.

Here’s a detailed breakdown of the smart contract functionalities:

1. **Lock Tokens**: Users can lock `EigenToken` tokens with different locking durations.
2. **Reward Calculation**: When users unlock their tokens, they receive 80% of their locked tokens back, and 20% are contributed to a rewards pool.
3. **Issue Voting Tokens**: Users receive "LASTIC" tokens proportionate to the duration they lock their tokens, which they can use to vote on projects to receive the rewards pool.
4. **Voting System**: Users can vote on different projects to determine the distribution of the 20% non-claimable rewards.

### Explanation

1. **Locking Tokens**: Users can lock `EigenToken` tokens, which are transferred from their account to the contract.
2. **Unlocking Tokens**: When unlocking, users receive 80% of their tokens, and 20% go into a rewards pool.
3. **LASTIC Token**: This is a simple ERC-20 token that users receive based on how long they lock their tokens. It's used for voting on projects.
4. **Voting and Reward Distribution**: Users can vote on projects to receive parts of the non-claimable 20% rewards.



## Get started 

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
