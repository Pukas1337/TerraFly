// SPDX-License-Identifier: UNLICENSED

// This code defines a smart contract for TerraFly tokens that implements the ERC-20 standard. It allows for minting, burning, and transferring of tokens, as well as checking the balance of a specific address. It also has events to emit when tokens are minted, burned, and transferred.
// It has a constructor to set the name, symbol, and decimals of the token.
// It also has a public variable totalSupply to keep track of the total number of tokens in circulation.
// It has a function approveAndTransfer that allows msg.sender to transfer tokens from another address.

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TerraFlyToken is ERC20 {
    // Variables
    mapping(address => uint256) public balanceOf;
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    // constructor
    constructor() public {
        name = "TerraFly Token";
        symbol = "FLY";
        decimals = 18;
    }

    // function to mint new tokens
    function mint(address _to, uint256 _value) public {
        require(msg.sender == msg.sender, "Only owner can mint tokens.");
        require(_value > 0, "Cannot mint 0 tokens.");
        totalSupply += _value;
        balanceOf[_to] += _value;
        emit Mint(_to, _value);
        emit Transfer(address(0), _to, _value);
    }

    // function to burn existing tokens
    function burn(address _from, uint256 _value) public {
        require(msg.sender == msg.sender, "Only owner can burn tokens.");
        require(_value > 0 && _value <= balanceOf[_from], "Invalid burn amount.");
        totalSupply -= _value;
        balanceOf[_from] -= _value;
        emit Burn(_from, _value);
        emit Transfer(_from, address(0), _value);
    }

    // function to transfer tokens
    function transfer(address _to, uint256 _value) public {
        require(_value <= balanceOf[msg.sender], "Insufficient balance.");
        require(_to != address(0), "Invalid address.");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
    }

    // function to approve and transfer tokens from another address
    function approveAndTransfer(address _from, address _to, uint256 _value) public {
        require(_from != address(0), "Invalid address.");
        require(_to != address(0), "Invalid address.");
        require(_value <= balanceOf[_from], "Insufficient balance.");
        require(msg.sender == _from, "Only msg.sender can approve and transfer tokens.");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
    }

    // function to check the balance of a specific address
    function checkBalance(address _owner) public view returns(uint256) {
        return balanceOf[_owner];
    }
}
