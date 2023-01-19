// SPDX-License-Identifier: UNLICENSED

// This code defines a smart contract named "ClimateTrade" that allows users to purchase carbon offsetting units using Ether.
// It has a mapping offsetUnits to keep track of the offset units of the user.
// It has events to emit when a user purchases offset units.
// It has a function purchaseOffsetUnits that accepts an amount of offset units as input and allows the user to purchase offset units with Ether.
// It has a function checkOffsetUnits that allows the user to check the balance of offset units in their account.

pragma solidity ^0.8.17;

contract ClimateTrade {

    // Variables
    mapping(address => uint256) public offsetUnits;

    // Events
    event Purchase(address indexed user, uint256 offsetUnits);

    // function to purchase offset units
    function purchaseOffsetUnits(uint256 _offsetUnits) public payable {
        require(_offsetUnits > 0, "Invalid offset units.");
        require(msg.value >= _offsetUnits, "Insufficient funds.");
        offsetUnits[msg.sender] += _offsetUnits;
        emit Purchase(msg.sender, _offsetUnits);
    }

    // function to check offset units balance
    function checkOffsetUnits() public view returns (uint256) {
        return offsetUnits[msg.sender];
    }
}
