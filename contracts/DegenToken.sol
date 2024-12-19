// SPDX-License-Identifier: MIT
/*
Objectives:
1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
2. Transferring tokens: Players should be able to transfer their tokens to others.
3. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4. Checking token balance: Players should be able to check their token balance at any time.
5. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20 {
    address public owner;
    struct Item {
        string name;
        uint256 cost;
    }
    mapping(uint256 => Item) public items;
    mapping(address => mapping(uint256 => bool)) public userRedeemedItems;

    constructor(address _owner) ERC20("Degen", "DGN") {
        owner = _owner;
        _mint(msg.sender, 100000000);
        items[1] = Item("Shirt", 100);
        items[2] = Item("Jacket", 250);
        items[3] = Item("Backpack", 150);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    function addItem(uint256 itemId, string memory name, uint256 cost) external onlyOwner {
        items[itemId] = Item(name, cost);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "You do not have enough tokens.");
        _burn(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        require(to != address(0), "Transfer to the zero address is not allowed");
        require(balanceOf(msg.sender) >= amount, "You do not have enough tokens.");
        _transfer(msg.sender, to, amount);
        return true;
    }

    function displayItems() public view returns (string memory) {
        string memory allItems;
        
        // Iterate over all the items to display them
        for (uint256 i = 1; i <= 3; i++) {
            string memory itemName = items[i].name;
            uint256 itemCost = items[i].cost;
            allItems = string(abi.encodePacked(allItems, "Item ID: ", uint2str(i), ", Name: ", itemName, ", Cost: ", uint2str(itemCost), " tokens\n"));
        }

        return allItems;
    }

    // convert uint to string
    function uint2str(uint256 _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        j = _i;
        while (j != 0) {
            bstr[--k] = bytes1(uint8(48 + j % 10));
            j /= 10;
        }
        return string(bstr);
    }

    function redeemTokens(uint256 itemId) public payable returns (bool) {
        uint256 price = items[itemId].cost;
        require(price > 0, "Invalid item ID");
        require(balanceOf(msg.sender) >= price, "Not enough tokens to redeem this item");
        
        transfer(owner, price);
        //_burn(msg.sender, price);
        return true;
    }

    function checkBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }    
}
