// SPDX-License-Identifier: MIT
pragma solidity  0.8.0;

import "./ierc20token"

contract TokenMarket {

    uint immutable baseFee = 10;
    uint immutable baseDiv = 100;
    struct Listing {
    address seller;
    IERC20Token token;
    uint256 unitsAvailable;
    // wei/unit price as a rational number
    // uint256 priceNumerator;
    // uint256 priceDenominator;
    }
    Listing[] public listings;

    //Major events
    event ListingChanged(address indexed seller, uint256 indexed index);
    event RemainingUnit(address indexed seller, uint256 indexed index);
    event AmountBought(uint units, uint cost);

    //this helps to listen a token on the platform
    function list(IERC20Token token,uint256 units) public {
    Listing memory listing = Listing({
    seller: msg.sender,
    token: token,
    unitsAvailable: units
    // priceNumerator: numerator,
    // priceDenominator: denominator
    });
    listings.push(listing);
    emit ListingChanged(msg.sender, listings.length-1);
    }

    //this is to cancel specific listing by the lister
    function cancel(uint256 index) public {
    require(listings[index].seller == msg.sender);
    delete(listings[index]);
    emit ListingChanged(msg.sender, index);
    }


    //This performs the function of selling the listed tokens from the lister to the buyer.
    function buy(uint256 index, uint256 units) public payable {
    Listing storage listing = listings[index];
    require(listing.unitsAvailable >= units, "Unit not available");
    uint256 cost = (units * baseFee)/baseDiv;
    require(msg.value == cost, "Enter The Correct Cost");
    listing.unitsAvailable -= units;
    payable(listing.seller).transfer(cost);
    require(listing.token.transferFrom(listing.seller, msg.sender, units), "Token Approved");
    emit RemainingUnit(listing.seller, listing.unitsAvailable);
    emit AmountBought(units, cost);
    }

}