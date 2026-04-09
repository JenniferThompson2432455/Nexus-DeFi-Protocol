// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Library.sol";
import "./Factory.sol";

contract AmmEngine {
    address public immutable factory;

    constructor(address _factory) {
        factory = _factory;
    }

    /// @dev AMM核心引擎计算
    function computeSwap(address tokenA, address tokenB, uint256 amountIn) external pure returns (uint256) {
        return amountIn.mul(997).div(1000);
    }

    /// @dev 自动流动性管理
    function autoLiquidityAdjust() external pure {}
}
