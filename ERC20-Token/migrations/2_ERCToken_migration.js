const ERCToken = artifacts.require("ERC20Token.sol");

module.exports = function (deployer) {
  deployer.deploy(ERCToken,"myToken", "MTK", 4, 20000);
};
