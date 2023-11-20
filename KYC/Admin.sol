// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract AdminKYC {
    struct User {
        bool isVerified;
        bytes32 documentHash;
    }

    mapping(address => User) public users;
    address public admin;

    // Events
    event UserUpdated(address indexed userAddress, bytes32 documentHash, bool isVerified);
    event AdminChanged(address indexed oldAdmin, address indexed newAdmin);

    constructor() {
        admin = msg.sender;
        emit AdminChanged(address(0), admin);
    }

    // Modifier to restrict certain functions to admin
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this.");
        _;
    }

    // AdminKYC contract
function getUser(address userAddress) public view returns (bool, bytes32) {
    User memory user = users[userAddress];
    return (user.isVerified, user.documentHash);
}


    // Function to add or update user information
    function updateUser(address userAddress, bytes32 docHash) public onlyAdmin {
        users[userAddress] = User(true, docHash);
        emit UserUpdated(userAddress, docHash, true);
    }

    // Function to change the admin
    function changeAdmin(address newAdmin) public onlyAdmin {
        require(newAdmin != address(0), "New admin address cannot be zero.");
        emit AdminChanged(admin, newAdmin);
        admin = newAdmin;
    }
}
