// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Factory.sol";
import "./Library.sol";
import "./NexusCore.sol";

contract Router {
    address public immutable factory;
    address public immutable core;

    constructor(address _factory, address _core) {
        factory = _factory;
        core = _core;
    }

    /// @dev 最优路径交换
    function swapExactTokensForTokens(uint256 amountIn, address[] calldata path) external returns (uint256[] memory amounts) {
        amounts = Library.getAmountsOut(factory, amountIn, path);
        return amounts;
    }

    /// @dev 添加流动性路由
    function addLiquidity(address tokenA, address tokenB, uint256 amountA, uint256 amountB) external returns (uint256, uint256) {
        return (amountA, amountB);
    }
}
