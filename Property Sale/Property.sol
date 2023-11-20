// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PropertyTransfer {
    struct Property {
        string addressLine;
        string location;
        uint floors;
        uint cost; 
        address sender;
    }

    mapping(uint => Property) public properties;
    mapping(uint => address) public propertyToOwner;
    mapping(address => uint[]) public ownerToProperties;
    uint public propertyCount = 0;

    event PropertyAdded(uint propertyId, string addressLine, string location, uint floors, uint cost, address indexed owner);
    event PropertyTransferred(uint propertyId, address indexed from, address indexed to);

    function addProperty(string memory _address, string memory _location, uint _floors, uint _cost) public {
        properties[propertyCount] = Property(_address, _location, _floors, _cost,msg.sender);
        propertyToOwner[propertyCount] = msg.sender;
        ownerToProperties[msg.sender].push(propertyCount);
        emit PropertyAdded(propertyCount, _address, _location, _floors, _cost, msg.sender);
        propertyCount++;
    }

    function transferProperty(uint _propertyId, address _newOwner) public {
        require(propertyToOwner[_propertyId] == msg.sender, "Caller is not the owner of the property");
        properties[_propertyId].sender =_newOwner;
        propertyToOwner[_propertyId] = _newOwner;
        emit PropertyTransferred(_propertyId, msg.sender, _newOwner);
    }

    function getMyProperties() public view returns (uint[] memory) {
        return ownerToProperties[msg.sender];
    }
}
