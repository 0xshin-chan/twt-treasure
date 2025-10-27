// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract TreasureManagerStorage {
    address public constant ethAddress = address(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);
    address public treasureManager;
    address public withdrawManager;
    address[] public tokenWhiteList;
    mapping(address => uint256) public tokenBalances;
    mapping(address => mapping(address => uint256)) public userRewardAmounts;
}
