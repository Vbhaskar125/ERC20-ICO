pragma solidity ^0.8.11;

interface EIP20Interface {

// @dev -- returns the balance of an address
// @param -- takes in the address whose balance is needed
// returns the balance as uint256    
function balanceOf(address _owner) external view returns (uint256);

//@dev -- transfers the value from msg.sender address to _to address and fires transfer event
//@param -- _to is the recipient address
//@param -- _value is the amount to be transferred
// returns a bool as per the success or failure of transfer
function transfer(address _to, uint256 _value) external returns (bool);

//@dev -- transfers tokens from _from address to _to address and fires Transfer event
//@param -- _from : source account for the transfer
//@param -- _to : destination account for the transfer
//@param -- _value : amount of tokens to be transferred
function transferFrom(address _from, address _to, uint256 _value) external returns (bool);

//@dev -- allows spender to transfer _value from msg.sender in one or multiple transactions. similar to power of attorney for upto  _value amount of tokens in the msg.sender account 
//@param -- _spender : the account allowed to use _value amount of tokens from msg.sender
//@param -- _valu : limit/amount of tokens, the spender is authorised to use 
function approve(address _spender, uint256 _value) external returns (bool);

//@dev -- returns the unspent approved balance which _spender can use from _owner account
//@param -- _owner: the account from which tokens are approved to the _spender
//@param -- _spender : the account which can use tokens from _owner account
//@return : returns the allowance remaining
function allowance(address _owner, address _spender)  external returns (uint256 );

//Events

//@dev -- must trigger on transfer of tokens (including 0 number of tokens)
//on creation of tokens trigger with _from address 0x0
event Transfer(address indexed _from, address indexed _to, uint256 _value);

//@dev -- must trigger on successful call to approve function
event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}