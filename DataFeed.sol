// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Ownable.sol";

contract DataFeed is Ownable {
    uint256 public latestPrice;
    uint256 public lastUpdate;

    event PriceFeedUpdated(uint256 price, uint256 timestamp);

    function updatePrice(uint256 newPrice) external onlyOwner {
        latestPrice = newPrice;
        lastUpdate = block.timestamp;
        emit PriceFeedUpdated(newPrice, block.timestamp);
    }

    function getLatestPrice() external view returns (uint256) {
        return latestPrice;
    }
}
