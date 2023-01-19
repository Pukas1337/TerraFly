// SPDX-License-Identifier: UNLICENSED

// The TerraFly contract is the main smart contract that manages the entire TerraFly system. It is responsible for tracking the user's carbon footprint using the RadarBox Oracle, minting TerraFly tokens according to the assigned ratio, offsetting carbon and redeeming TerraFly tokens. 
// It also allows users to access the benefits of the partnerships and purchase carbon offsetting units through the ClimateTrade integration.

// The contract has several functions that are used to achieve the above objectives:

// The trackCarbonFootprint() function is used to track the carbon footprint of a user, it takes the user's address and flight data as input and uses the RadarBox Oracle to calculate the carbon footprint.
// The mintTerraFly() function is used to mint TerraFly tokens for a user based on their carbon footprint, it takes the user's address as input and mints the tokens according to the assigned ratio.
// The offsetCarbon() function is used to offset the carbon emissions of a user, it takes the user's address and the number of offset units as input and uses the CarbonOffsetting contract to offset the emissions.
// The redeemTerraFly() function is used to redeem TerraFly tokens for benefits, it takes the user's address and the number of tokens as input and uses the TokenExchange contract to redeem the tokens.
// The getBenefits() function is used to get the benefits from the partnerships, it takes the user's address as input and uses the Partnerships contract to get the benefits.
// The purchaseCarbonOffsetting() function is used to purchase carbon offsetting units, it takes the user's address and the number of offset units as input and uses the ClimateTrade contract to purchase the offset units.
// The TerraFly contract also has several state variables:

// owner is the address of the contract's owner.
// userCarbonFootprint is a mapping of user's addresses to their carbon footprint.
// radarBoxOracle, carbonOffsetting, tokenExchange, partnerships, climateTrade are the addresses of the contracts that are used to interact with the RadarBox Oracle, CarbonOffsetting, TokenExchange, Partnerships, and ClimateTrade.
// terraFlyToken is the address of the TerraFly token contract.
// ratio is the ratio of TerraFly tokens minted per unit of carbon offset.

pragma solidity ^0.8.17;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./RadarBoxOracle.sol";
import "./CarbonOffsetting.sol";
import "./TokenExchange.sol";
import "./Partnerships.sol";
import "./ClimateTrade.sol";

contract TerraFly {

    // Variables
    address public owner;
    mapping (address => uint256) public userCarbonFootprint;
    RadarBoxOracle public radarBoxOracle;
    CarbonOffsetting public carbonOffsetting;
    TokenExchange public tokenExchange;
    Partnerships public partnerships;
    ClimateTrade public climateTrade;
    ERC20 public terraFlyToken;
    uint256 public ratio; // ratio of TerraFly tokens minted per unit of carbon offset

    // Events
    event CarbonFootprintCalculated(address indexed user, uint256 carbonFootprint);
    event TerraFlyMinted(address indexed user, uint256 terraFlyTokens);
    event TerraFlyUnlocked(address indexed user, uint256 terraFlyTokens);

    constructor(address _radarBoxOracle, address _carbonOffsetting, address _tokenExchange, address _partnerships, address _climateTrade, address _terraFlyToken, uint256 _ratio) public {
        owner = msg.sender;
        radarBoxOracle = RadarBoxOracle(_radarBoxOracle);
        carbonOffsetting = CarbonOffsetting(_carbonOffsetting);
        tokenExchange = TokenExchange(_tokenExchange);
        partnerships = Partnerships(_partnerships);
        climateTrade = ClimateTrade(_climateTrade);
        terraFlyToken = ERC20(_terraFlyToken);
        ratio = _ratio;
    }

    function trackCarbonFootprint(address _user, string memory _flightNumber, uint256 _timestamp) public {
        require(msg.sender == owner);
        (bool success, uint256 carbonFootprint) = radarBoxOracle.getFlightData(_user, _flightNumber, _timestamp);
        require(success);
        userCarbonFootprint[_user] += carbonFootprint;
        emit CarbonFootprintCalculated(_user, carbonFootprint);
    }

    function mintTerraFly(address _user) public {
        require(msg.sender == owner);
        uint256 carbonFootprint = userCarbonFootprint[_user];
        uint256 terraFlyTokens = carbonFootprint * ratio;
        terraFlyToken.mint(_user, terraFlyTokens);
        emit TerraFlyMinted(_user, terraFlyTokens);
    }

    function offsetCarbon(address _user, uint256 _offsetUnits) public {
        require(msg.sender == _user);
        require(carbonOffsetting.offsetCarbon(_user, _offsetUnits));
        require(terraFlyToken.unlock(_user, userCarbonFootprint[_user]));
        emit TerraFlyUnlocked(_user, userCarbonFootprint[_user]);
    }

    function redeemTerraFly(address _user, uint256 _terraFlyTokens) public {
        require(msg.sender == _user);
        require(terraFlyToken.transfer(_user, _terraFlyTokens));
        require(tokenExchange.redeemTerraFly(_user, _terraFlyTokens));
        terraFlyToken.burn(_user, _terraFlyTokens);
    }
        function getBenefits(address _user) public view returns (bool success, uint256 benefits) {
        require(msg.sender == _user);
        (success, benefits) = partnerships.getBenefits(_user);
        return (success, benefits);
    }

        function purchaseCarbonOffsetting(address _user, uint256 _offsetUnits) public {
        require(msg.sender == _user);
        require(climateTrade.purchaseCarbonOffsetting(_user, _offsetUnits));
    }
}
