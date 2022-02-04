const ico = artifacts.require("ICO.sol");

module.exports = function (deployer) {
    deployer.deploy(ico,"myToken", "MTK", 4, 20000);
  };