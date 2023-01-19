// SPDX-License-Identifier: UNLICENSED

// This code defines a smart contract named "CarbonOffsetting" that allows users to send offset units, check their offset status and redeem offset units to unlock TerraFly tokens.
// It has a mapping offsetStatus to keep track of the offset status of the user.
// It has a mapping offsetUnits to keep track of the offset units of the user.
// It has a variable terraFly that holds the TerraFly token contract.
// It has events to emit when user offset his carbon emissions.
// The constructor accepts the TerraFly token contract as a parameter, so that the contract has a reference to it.
// It also has a function redeemOffsetUnits that can be used to redeem offset units for unlocking the TerraFly tokens

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CarbonOffsetting {

    // Variables
    mapping(address => bool) public offsetStatus;
    mapping(address => uint256) public offsetUnits;
    TerraFlyToken terraFly;

    // Events
    event Offset(address indexed user, uint256 offsetUnits);

    // constructor
    constructor(TerraFlyToken _terraFly) public {
        terraFly = _terraFly;
    }

    // function to receive offset units
    function receiveOffsetUnits(uint256 _offsetUnits) public {
        require(_offsetUnits > 0, "Invalid offset units.");
        offsetUnits[msg.sender] += _offsetUnits;
        emit Offset(msg.sender, _offsetUnits);
    }

    // function to check offset status
    function checkOffsetStatus() public view returns (bool) {
        return offsetStatus[msg.sender];
    }

    // function to redeem offset units
    function redeemOffsetUnits() public {
        require(offsetStatus[msg.sender] == false, "Cannot redeem offset units without offsetting.");
        offsetStatus[msg.sender] = true;
        terraFly.unlock(msg.sender);
    }
}
