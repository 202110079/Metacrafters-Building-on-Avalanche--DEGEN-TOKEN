# METACRAFTERS Building on AVALANCHE: DEGEN TOKEN

This is a submission for the Metacrafters Building on AVALANCHE project.

## Description

This project implements a smart contract on the Fuji Test network. The requirements provided by Metacrafters are as follows:
1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
2. Transferring tokens: Players should be able to transfer their tokens to others.
3. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4. Checking token balance: Players should be able to check their token balance at any time.
5. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.

The contract is completely capable of all of the above.

## Functions

Besides the core functions of minting, transferring, and burning tokens, the contract also has specialized item redemption functions. 

The items that can be redeemed can be added or changed at any time using the addItem function. Whenever a player wants to redeem an item, they can use the redeemItem function, which will take the cost of the item they want to redeem, and it will then pay those tokens to the contract owner who owns the redemption items. As such, the redemption function is a payable function.

## How to run

To run, open a command terminal and paste: npx hardhat run scripts/deploy.js --network fuji

The contract will then output an address that can be monitored using Snowtrace.