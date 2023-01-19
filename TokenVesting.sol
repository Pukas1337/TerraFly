// SPDX-License-Identifier: UNLICENSED

// the TokenVesting contract is a smart contract that handles the vesting schedule of tokens. It ensures that the tokens are locked until the vesting period is over. It has three main functions:

// The addVesting() function allows an address to be added to the vesting schedule with a specified cliff and duration. The cliff is the amount of time in seconds before tokens can be released, and the duration is the total amount of time in seconds that the tokens will be locked for.

// The release() function allows an address to release their tokens if the vesting period is over. It checks if the current time is greater than or equal to the time specified in the vesting schedule for the given address.

// The isVested() function returns a boolean indicating whether or not the tokens for a given address are vested and able to be released.

pragma solidity ^0.8.17;

contract TokenVesting {
    mapping(address => uint256) public vestingSchedule;

    function addVesting(address tokenHolder, uint256 cliff, uint256 duration) public {
        require(cliff > 0 && duration > 0);
        vestingSchedule[tokenHolder] = block.timestamp + cliff + duration;
    }

    function release(address tokenHolder) public view {
        require(vestingSchedule[tokenHolder] <= block.timestamp);
    }

    function isVested(address tokenHolder) public view returns (bool) {
        return vestingSchedule[tokenHolder] <= block.timestamp;
    }
}
