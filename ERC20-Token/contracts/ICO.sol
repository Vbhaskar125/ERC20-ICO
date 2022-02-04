//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;
import  './ERC20Token.sol';
contract ICO{
    
    ERC20Token public token;
    address payable public admin_;
    uint256 public endTime_;
    uint256 public availableTokens_;
    uint256 public minTokens_;
    uint256 public maxTokens_;
    uint256 public priceOfToken_;
    uint256 public amountRaised_;
    bool public tokensReleased_;
    address[] public investors;
    mapping (address => uint) purchaseRecord;



constructor(
    string memory _tokenName, string memory _tokenSymbol, uint8 _tokenDecimals, uint _tokenSupply
    ){
    token = new ERC20Token(_tokenName, _tokenSymbol, _tokenDecimals, _tokenSupply);
    admin_ = payable(msg.sender); 
}

function startSale(
    uint _icoInterval, uint _tokensAvailable, uint _minPurchase, uint _maxPurchase, uint _tokenPrice
    ) public onlyAdmin icoInactive{
        require(_icoInterval >0, "ico interval >0");
        endTime_ = block.timestamp + _icoInterval;
        require(_tokensAvailable > 0, "tokens available for ICO >0");
        availableTokens_ = _tokensAvailable;
        require(_minPurchase > 0 && _minPurchase < token.totalSupply());
        minTokens_ = _minPurchase;
        require(_maxPurchase <= token.totalSupply());
        maxTokens_ = _maxPurchase;
        priceOfToken_ = _tokenPrice;
        amountRaised_ =0;
       }

function isIcoActive() external view returns (bool){
    if(endTime_ != 0 && endTime_ >  block.timestamp) return true;
    return false;
}

function buy(uint _quantity) payable external icoIsActive returns (bool success){
    require(_quantity > minTokens_ && _quantity < maxTokens_ ,"out of token limits");
    require(msg.value >= _quantity * priceOfToken_ , "ETH sent is insufficient");
    require(availableTokens_ >= _quantity , "less tokens are available");
    purchaseRecord[msg.sender]= _quantity;
    availableTokens_ -= _quantity;
    investors.push(msg.sender);
    amountRaised_ += _quantity * priceOfToken_ ;
    return true;
}

function releaseTokens() external onlyAdmin icoInactive{
    ERC20Token tokenInstance = ERC20Token(token);
    for(uint i =0; i< investors.length; i++){
        address buyer = investors[i];
        tokenInstance.transfer(buyer, purchaseRecord[buyer]);
    }
    tokensReleased_ =true;
}

function withdraw(address payable _to) external onlyAdmin icoInactive TokensReleased{
     _to.transfer(amountRaised_);
}

function close() external onlyAdmin{
selfdestruct(admin_);
}

//modifiers

modifier onlyAdmin(){
    require(msg.sender == admin_);
    _;
}

modifier icoInactive(){
    require(endTime_ == 0 || endTime_ <= block.timestamp);
    _;
}

modifier icoIsActive(){
    require(block.timestamp < endTime_);
    _;
}

modifier TokensReleased(){
    require(tokensReleased_ == true);
    _;
}

}

// constructor : creates a token, number of tokens allocated to ICO, msg.sender as owner of ICO(on selfdestruct, remaining coins will be transferred to the owner)
//
//start sale : min & max no of tokens limit, value of 1 token in ETh, ICO start and end time in ms, available tokens
//can be started only by admin and when no ico is in progress
//
//buy() : after the required checks,  add the buyer to the investor list along with the number of tokens purchased, update the available no of tokens
//
//Releasetokens() : transfer tokens in the investor list (after sale end and only by admin)
//
//withdraw() : withdraw the amount raised
//
