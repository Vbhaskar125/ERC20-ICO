const ERCToken = artifacts.require('./ERC20Token.sol');

contract('ERCToken', (accounts) => {
var tokenInstance;

before(async () => {
     tokenInstance = await ERCToken.deployed();
});
    

it('verify token creation with  initialSupply as 20000', async()=>{
  const supp = await tokenInstance.totalSupply();
  assert.equal(supp.toNumber(), 20000,"initialzed with 20000tokens supply");
});


it('verify token creation with name as myToken', async()=>{
    const _name = await tokenInstance.name();;
    assert.equal(_name.toString(),"myToken", "name is myToken" );
});


it('verify token creation with  symbol as MTK', async()=>{
    const _symb = await tokenInstance.symbol();;
    assert.equal(_symb.toString(),"MTK", "token symbol is MTK" );
});


it('transfer function testing', async()=>{
    try{
    await tokenInstance.transfer.call(accounts[1],90000,{from: accounts[0]} );
    }catch(e){
        assert(e.message.indexOf('revert')>=0 ,"error message \"revert\"");
        return;
    }
    assert(false);
});


it('verify transfer of 1000 tokens', async()=>{
    const _symb = await tokenInstance.transfer(accounts[1], 1000 ,{from: accounts[0]} );
    assert(_symb.logs[0].event, "Transfer", "transfer event firing");
    assert.equal(_symb.receipt.status ,true, "transfer was successful" );
    const account1_balance = await tokenInstance.balance(accounts[1]);
    assert.equal(account1_balance, 1000, "10 tokens are in destination account");
});


it("returns balance", async() =>{
    let _bal = tokenInstance.balanceOf(accounts[1])
    assert(_bal, 1000, "1000 tokens in account1");
});

it('fails to approve more than the account balance', async()=> {
    try{
        //console.log(await tokenInstance.balance(accounts[1]));
       await tokenInstance.approve(accounts[3], 4000, {from: accounts[1]});
    }catch(e){
    //    console.log(e)
        assert(e.message.indexOf('revert')>=0, "reverting approval for more than balance");
        return;
    }
    assert(false);
});

it('approve 500 tokens' , async() =>{
    const _receipt = await tokenInstance.approve(accounts[3], 500, {from: accounts[1]});
    assert(_receipt.logs[0].event,"Approval", "approval event emitted");
    const _approvedValue = await tokenInstance.allowance(accounts[1],accounts[3]);
    assert(_approvedValue, 500, "verified the approved value");
});

it('transfer allowance of account3 from account1 to account 5' , async() =>{
    const _receipt = await tokenInstance.transferFrom(accounts[1], accounts[5], 300, {from: accounts[3]})
    assert(_receipt.logs[0].event, "Transfer", "transfer event");
    const _decaAllowance = await tokenInstance.allowance(accounts[1], accounts[3])
    assert(_decaAllowance, 200, "allowance dec by 300");
    const _finbal = await tokenInstance.balanceOf(accounts[5]);
    assert(_finbal, 300, "300 was transferred");
});


});
 