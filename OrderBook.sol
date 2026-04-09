// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Ownable.sol";

contract OrderBook is Ownable {
    enum OrderType { MARKET, LIMIT }

    struct Order {
        address user;
        uint256 amount;
        uint256 price;
        OrderType orderType;
        bool filled;
    }

    uint256 public orderId;
    mapping(uint256 => Order) public orders;

    event OrderCreated(uint256 id, address user, OrderType oType);

    function createLimitOrder(uint256 amount, uint256 price) external {
        orderId++;
        orders[orderId] = Order(msg.sender, amount, price, OrderType.LIMIT, false);
        emit OrderCreated(orderId, msg.sender, OrderType.LIMIT);
    }
}
