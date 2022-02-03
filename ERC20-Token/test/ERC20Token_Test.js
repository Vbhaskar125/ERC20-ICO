const ERCToken = artifacts.require('./ERC20Token.sol');

contract('ERCToken', accounts => {
var tokenInstance;
    
it('verify token creation with name as myToken, initialSupply as 20000, symbol as MTK', function(){
        return ERCToken.deployed()
        .then(function(instance){
    tokenInstance=instance;
    return tokenInstance.totalSupply();
        }).then((supply)=>{
            assert.equal(supply.toNumber(),20000,"initialzed with 20000tokens supply");
            return tokenInstance.name();
        }).then(nameofToken => {
            assert.equal(nameofToken.toString(),"myToken", "name is myToken");
            return tokenInstance.symbol()
        }).then((tokensymbol) => {
            assert.equal(tokensymbol.toString(),"MTK", "token symbol is MTK");
        })
    });

it("transfer function testing", () => {
    return ERCToken.deployed()
    .then((instance) => {
        tokenInstance= instance;
        return tokenInstance.transfer.call(accounts[1],90000,{from: accounts[0]} )
    }).then(assert.fail).catch((error)=>{
        assert(error.message.indexOf('revert')>=0 ,"error message \"revert\"");

    })
});


});