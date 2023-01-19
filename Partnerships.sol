// SPDX-License-Identifier: UNLICENSED

// This contract uses a mapping data structure to store the list of partners. 
// The addPartner() function adds a new partner to the list by setting the value of the mapping corresponding to the partner's address to true. 
// The removePartner() function removes a partner from the list by deleting the corresponding mapping. 
// The isPartner() function is a view function that returns a boolean indicating whether the provided address is a partner or not.

pragma solidity ^0.8.17;

contract Partnerships {
    mapping(address => bool) public partnersList;

    function addPartner(address _partner) public {
        partnersList[_partner] = true;
    }

    function removePartner(address _partner) public {
        delete partnersList[_partner];
    }

    function isPartner(address _partner) public view returns (bool) {
        return partnersList[_partner];
    }
}

