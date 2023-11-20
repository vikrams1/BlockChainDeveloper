// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract OnlineJewelleryStore {
    // Define a structure to represent a jewelry item
    struct Jewelry {
        uint id;
        string itemType;
        uint price;
        string material;
        bool isSold;
    }

    // Array to store all jewelry items
    Jewelry[] public jewelries;

    // Mapping to keep track of purchased items
    mapping(uint => bool) public purchasedItems;

    // Constructor to initialize the jewelry catalog
    constructor() {
        // Adding items to the catalog
        jewelries.push(Jewelry(1, "Ring", 200, "Gold", false));
        jewelries.push(Jewelry(2, "Chain", 300, "Platinum", false));
        jewelries.push(Jewelry(3, "Stone", 400, "Silver", false));
    }

    // Function to display available jewelry
    function displayAvailableJewelry() external view returns (Jewelry[] memory) {
        uint availableItemCount = 0;
        for (uint i = 0; i < jewelries.length; i++) {
            if (!jewelries[i].isSold) {
                availableItemCount++;
            }
        }

        Jewelry[] memory availableItems = new Jewelry[](availableItemCount);
        uint j = 0;
        for (uint i = 0; i < jewelries.length; i++) {
            if (!jewelries[i].isSold) {
                availableItems[j] = jewelries[i];
                j++;
            }
        }
        return availableItems;
    }

    // Function to purchase a jewelry item
    function purchaseItem(uint id) external returns (string memory) {
        require(id > 0 && id <= jewelries.length, "Item does not exist.");
        require(!purchasedItems[id], "This item has already been purchased.");

        purchasedItems[id] = true;
        jewelries[id - 1].isSold = true;

        return "Success";
    }
}
