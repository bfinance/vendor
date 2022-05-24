const Vendor = artifacts.require("./TokenMarket.sol");

contract("TokenMarket", accounts => {
  let vendorInstance;
  
  before(async() => {
    vendorInstance = await Vendor.deployed();
  });

  it("List a token", async () => {
    try{
      await vendorInstance.list.sendTransaction("0x38CaCA78E42a64F150844824d796adF6125F270E",
      BigInt(100000),
      BigInt(1000000000000000),
      BigInt(1000000000000000000), { from: accounts[0] });
      let lister = await vendorInstance.listings.call(0);
      assert.equal(lister[0], accounts[0], "Account not listed.");
      assert.equal(lister[1], "0x38CaCA78E42a64F150844824d796adF6125F270E", "Token not listed.");
    }catch (error){
      assert.include(String(error), "revert",`Expected "Revert" but got ${error}`)
    }
    });


  it("Buy a token", async () => {
    try{
      await vendorInstance.buy.sendTransaction(0, 10000, { from: accounts[0] });
    }catch (error){
      assert.include(String(error), "revert",`Expected "Revert" but got ${error}`)
    }
    }); 

  it("Cancel a token", async () => {
    try{
      await vendorInstance.cancel.sendTransaction(0, { from: accounts[0] });
      let lister = await vendorInstance.listings.call(0);
      assert.equal(lister[0], "0x0000000000000000000000000000000000000000", "Cancel Failed.");
    }catch (error){
      assert.include(String(error), "revert",`Expected "Revert" but got ${error}`)
    }
    });

});
