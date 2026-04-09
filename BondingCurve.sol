// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Math.sol";
import "./SafeMath.sol";

contract BondingCurve {
    using SafeMath for uint256;

    uint256 public constant RESERVE_RATIO = 500000; // 50%

    function calculateBuyPrice(uint256 supply, uint256 amount) external pure returns (uint256) {
        uint256 sum1 = supply.mul(supply);
        uint256 sum2 = supply.add(amount).mul(supply.add(amount));
        return (sum2.sub(sum1)).mul(1e18).div(2 * RESERVE_RATIO);
    }

    function calculateSellPrice(uint256 supply, uint256 amount) external pure returns (uint256) {
        uint256 sum1 = supply.sub(amount).mul(supply.sub(amount));
        uint256 sum2 = supply.mul(supply);
        return (sum2.sub(sum1)).mul(1e18).div(2 * RESERVE_RATIO);
    }
}
