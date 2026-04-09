// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Pair.sol";
import "./Ownable.sol";

contract Factory is Ownable {
    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    event PairCreated(address indexed tokenA, address indexed tokenB, address pair, uint256 index);

    /// @dev 创建交易对
    function createPair(address tokenA, address tokenB) external returns (address pair) {
        require(tokenA != tokenB, "Identical addresses");
        require(getPair[tokenA][tokenB] == address(0), "Pair exists");

        pair = address(new Pair(tokenA, tokenB));
        getPair[tokenA][tokenB] = pair;
        getPair[tokenB][tokenA] = pair;
        allPairs.push(pair);

        emit PairCreated(tokenA, tokenB, pair, allPairs.length);
    }

    function allPairsLength() external view returns (uint256) {
        return allPairs.length;
    }
}
