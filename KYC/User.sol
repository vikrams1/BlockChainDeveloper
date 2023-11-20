// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Admin.sol";

contract ViewDataKYC {
    AdminKYC private adminContract;

    constructor(address adminContractAddress) {
        adminContract = AdminKYC(adminContractAddress);
    }

    // Function to verify user's document hash
    function verifyUser(address userAddress, bytes32 docHash) public view returns (bool) {
        (bool isVerified, bytes32 storedHash) = adminContract.users(userAddress);
        return isVerified && storedHash == docHash;
    }

    // Function to check if a user is verified
    function isUserVerified(address userAddress) public view returns (bool) {
        (bool isVerified,) = adminContract.users(userAddress);
        return isVerified;
    }

// Function to return user data from the AdminKYC contract
    function getUserData(address userAddress) public view returns (bool, bytes32) {
       (bool isVerified, bytes32 storedHash) = adminContract.users(userAddress);
        return (isVerified, storedHash);
    }
    
}

