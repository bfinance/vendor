// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
interface IERC20Token {
    function totalSupply() external  returns (uint);
    function balanceOf(address tokenlender) external  returns (uint balance);
    function allowance(address tokenlender, address spender) external  returns (uint remaining);
    function transfer(address to, uint tokens) external returns (bool success);
    function approve(address spender, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenlender, address indexed spender, uint tokens);
}