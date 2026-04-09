// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Ownable.sol";
import "./DataFeed.sol";

contract PriceOracle is Ownable {
    mapping(address => address) public tokenFeeds;
    mapping(address => uint256) public lastPrice;

    event PriceUpdated(address indexed token, uint256 price);

    /// @dev 绑定代币价格数据源
    function setTokenFeed(address token, address feed) external onlyOwner {
        tokenFeeds[token] = feed;
    }

    /// @dev 获取最新价格
    function getPrice(address token) external returns (uint256) {
        require(tokenFeeds[token] != address(0), "No feed set");
        DataFeed feed = DataFeed(tokenFeeds[token]);
        uint256 price = feed.getLatestPrice();
        lastPrice[token] = price;
        emit PriceUpdated(token, price);
        return price;
    }

    /// @dev 读取历史价格
    function getLastPrice(address token) external view returns (uint256) {
        return lastPrice[token];
    }
}
