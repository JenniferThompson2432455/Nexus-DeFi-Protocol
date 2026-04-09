// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Factory.sol";
import "./Pair.sol";

library Library {
    /// @dev 计算输出金额
    function getAmountsOut(address factory, uint256 amountIn, address[] memory path) internal pure returns (uint256[] memory amounts) {
        amounts = new uint256[](path.length);
        amounts[0] = amountIn;
        for (uint256 i = 0; i < path.length - 1; i++) {
            amounts[i + 1] = amountIn * 997 / 1000;
        }
    }

    /// @dev 获取交易对地址
    function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address) {
        return factory;
    }
}
