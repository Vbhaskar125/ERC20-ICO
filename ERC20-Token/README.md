
 This is an implementation of EIP-20 for tokens proposed by Vogelsteller, Buterin.
 reference :Fabian Vogelsteller, Vitalik Buterin, "EIP-20: Token Standard," Ethereum Improvement Proposals, no. 20, November 2015. [Online serial]. Available: https://eips.ethereum.org/EIPS/eip-20.

https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md

basic functionality - to facilitate transfer and transaction of tokens, as well as allow tokens to be approved to  be spent by on-chain 3rd party

                                               
                                               methods as specified in EIP20
                                               

                                                function name() public view returns (string)
 name ( Returns the name of the token - e.g. "MyToken")    

                
                                                    
                                                function symbol() public view returns (string)
 symbol (Returns the symbol of the token. ) 
 
                                                function decimals() public view returns (uint8)

decimals ( Returns the number of decimals the token uses - e.g. 8, means to divide the token amount by 100000000 to get its user representation. )
                                                          
                                                         
                                                function totalSupply() public view returns (uint256)

totalSupply ( Returns the total token supply.)              

                                    function balanceOf(address _owner) public view returns (uint256 balance)                 
balanceOf ( Returns the account balance of another account with address _owner) 

                                   function transfer(address _to, uint256 _value) public returns (bool success)
<-- Transfers _value amount of tokens to address _to, and MUST fire the Transfer event. The function SHOULD throw if the message caller’s account balance does not have enough tokens to spend. -->
<-- Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event. -->
                                             
                                            
                         function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
transferFrom <--Transfers _value amount of tokens from address _from to address _to, and MUST fire the Transfer event.-->
                                  
                                  
                        function approve(address _spender, uint256 _value) public returns (bool success)
 approve <-- Allows _spender to withdraw from your account multiple times, up to the _value amount. If this function is called again it overwrites the current allowance with _value. -->
                                 
                                
                       function allowance(address _owner, address _spender) public view returns (uint256 remaining)
allowance <-- Returns the amount which _spender is still allowed to withdraw from _owner. -->
                               
                              


                                        Events
  
                             event Transfer(address indexed _from, address indexed _to, uint256 _value)
 Transfer <--MUST trigger when tokens are transferred, including zero value transfers.-->
 <-- A token contract which creates new tokens SHOULD trigger a Transfer event with the _from address set to 0x0 when tokens are created. -->
                                     
                                   

                             event Approval(address indexed _owner, address indexed _spender, uint256 _value)
Approval <--MUST trigger on any successful call to approve(address _spender, uint256 _value).-->
                                 
                                 
