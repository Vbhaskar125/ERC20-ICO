//SPDX License Identifier: MIT
pragma solidity ^0.8.11;
import './EIP20Interface.sol';

contract ERC20Token is EIP20Interface {

//@dev -- 
mapping(address => uint256) public balance;

mapping(address => mapping(address => uint256)) public approved;

string public name;
string public symbol;
uint8 public decimals;
uint256 public totalSupply;
uint256 MAX_INT = type(uint256).max; 

constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _totalSupply){
name = _name;
symbol = _symbol;
decimals = _decimals;
totalSupply = _totalSupply;
balance[msg.sender] = _totalSupply;
}

function balanceOf(address _address) public view returns (uint256){
 return balance[_address];
}


function transfer(address _to, uint256 _value) public returns (bool success){
require( balance[msg.sender] >= _value);
balance[msg.sender] -= _value;
balance[_to] += _value;
emit Transfer(msg.sender, _to, _value);
return true;
}

function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
require(allowance(_from, msg.sender) >= _value);
require(balanceOf(_from) >= _value);
approved[_from][msg.sender] -= _value;
balance[_from] -= _value;
balance[_to] += _value;
emit Transfer(_from, _to, _value);
return true;
}

function approve(address _spender, uint256 _value) public returns (bool success){
 require(balanceOf(msg.sender) >= _value);
 approved[msg.sender][_spender]= _value;
 emit Approval(msg.sender, _spender,  _value);
 return true;
}

function allowance(address _owner, address _spender)  public view returns (uint256 ){
return approved[_owner][_spender];
}


}