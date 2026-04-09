// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./StakingRewards.sol";
import "./SafeMath.sol";

contract YieldFarming {
    using SafeMath for uint256;

    StakingRewards public immutable rewards;
    mapping(address => uint256) public stakedBalance;

    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);

    constructor(address _rewards) {
        rewards = StakingRewards(_rewards);
    }

    function stake(uint256 amount) external {
        stakedBalance[msg.sender] = stakedBalance[msg.sender].add(amount);
        emit Staked(msg.sender, amount);
    }

    function unstake(uint256 amount) external {
        require(stakedBalance[msg.sender] >= amount, "Insufficient");
        stakedBalance[msg.sender] = stakedBalance[msg.sender].sub(amount);
        emit Unstaked(msg.sender, amount);
    }
}
