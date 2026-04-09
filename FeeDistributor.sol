// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./SafeMath.sol";
import "./StakingRewards.sol";

contract FeeDistributor {
    using SafeMath for uint256;

    address public immutable rewards;
    uint256 public totalFees;

    constructor(address _rewards) {
        rewards = _rewards;
    }

    function distributeFees() external {
        uint256 fee = address(this).balance;
        totalFees = totalFees.add(fee);
        payable(rewards).transfer(fee);
    }
}
