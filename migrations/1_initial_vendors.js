const Vendors = artifacts.require("./TokenMarket.sol");

module.exports = function (deployer) {
  deployer.deploy(Vendors);
};
