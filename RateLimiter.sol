// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RateLimiter {
    mapping(address => uint256) public lastCall;
    uint256 public cooldown = 1 minutes;

    modifier rateLimited() {
        require(block.timestamp >= lastCall[msg.sender] + cooldown, "Too fast");
        lastCall[msg.sender] = block.timestamp;
        _;
    }

    function setCooldown(uint256 newCooldown) external {
        cooldown = newCooldown;
    }
}
