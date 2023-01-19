// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "./TerraFly.sol";
import "./TerraFlyToken.sol";
import "./Partnerships.sol";
import "./CarbonOffsetting.sol";
import "./TokenVesting.sol";
import "./TokenExchange.sol";
import "./RadarBoxOracle.sol";
import "./ClimateTrade.sol";

// Test contract for TerraFly system
contract TerraFlyTest {
using SafeMath for uint256;
TerraFly terraFly;
TerraFlyToken terraFlyToken;
Partnerships partnerships;
CarbonOffsetting carbonOffsetting;
TokenVesting tokenVesting;
TokenExchange tokenExchange;
RadarBoxOracle radarBoxOracle;
ClimateTrade climateTrade;

// Test function to simulate a user offsetting their carbon emissions through TerraFly
function testOffsetEmissions() public {
    // Assign offset units to user
    uint offsetUnits = 100;
    carbonOffsetting.addOffsetUnits(offsetUnits);
    // Check if offset units have been added to user's account
    assert(carbonOffsetting.getUserOffsetUnits() == offsetUnits, "Offset units were not added to user's account");
    // Check if TerraFly tokens are minted for the user
    assert(terraFlyToken.balanceOf(address(this)) > 0, "TerraFly tokens were not minted for user");
}

// Test function to simulate a user redeeming their TerraFly tokens for benefits
function testRedeemTokens() public {
    // Assign offset units to user
    uint offsetUnits = 100;
    carbonOffsetting.addOffsetUnits(offsetUnits);
    // Check if offset units have been added to user's account
    assert(carbonOffsetting.getUserOffsetUnits() == offsetUnits, "Offset units were not added to user's account");
    // Check if TerraFly tokens are minted for the user
    assert(terraFlyToken.balanceOf(address(this)) > 0, "TerraFly tokens were not minted for user");
    // Redeem tokens for benefits
    terraFly.redeemTokens();
    // Check if tokens have been burned
    assert(terraFlyToken.balanceOf(address(this)) == 0, "Tokens were not burned");
}

}
