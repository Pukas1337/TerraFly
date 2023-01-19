// SPDX-License-Identifier: UNLICENSED

// This is a basic example of how a RadarBoxOracle contract could be implemented using the Chainlink oracle. 
// The contract has a setRequest function that is used to set the address of the Chainlink oracle contract. 
// The getFlightData function is used to call the oracle and get flight data. 
// The fulfill function is used to receive the flight data from the oracle and emit the FlightDataReceived event. 
// The buildChainlinkRequest function is used to construct a Chainlink request.

pragma solidity ^0.8.17;
import "https://github.com/smartcontractkit/chainlink/blob/main/evm-contracts/src/v0.6/interfaces/ChainlinkRequestInterface.sol";

contract RadarBoxOracle {
    address public owner;
    ChainlinkRequestInterface public request;

    event FlightDataReceived(address indexed user, uint256 carbonFootprint);

    constructor() public {
        owner = msg.sender;
    }

    function setRequest(address _request) public {
        require(msg.sender == owner);
        request = ChainlinkRequestInterface(_request);
    }

    function getFlightData(address _user, string memory _flightNumber, uint256 _timestamp) public {
        require(msg.sender == owner);
        Chainlink.Request memory req = buildChainlinkRequest(_user, _flightNumber, _timestamp);
        request.fulfillOracleRequest(req, address(this));
    }

    function fulfill(bytes32 _requestId, uint256 _carbonFootprint) public {
        require(msg.sender == request.oracle());
        emit FlightDataReceived(msg.sender, _carbonFootprint);
    }

    function buildChainlinkRequest(address _user, string memory _flightNumber, uint256 _timestamp) private pure returns (Chainlink.Request memory) {
        Chainlink.Request memory req = new Chainlink.Request({
            oracleScriptId: ORACLE_SCRIPT_ID,
            jobId: JOB_ID,
            payment: 0,
            callbackAddress: address(this),
            callbackFunctionId: CALLBACK_ID,
            data: abi.encodePacked(_user, _flightNumber, _timestamp)
        });
        return req;
    }
}
