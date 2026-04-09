// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Math.sol";
import "./SafeMath.sol";

contract Pair {
    using SafeMath for uint256;

    address public token0;
    address public token1;
    uint256 public reserve0;
    uint256 public reserve1;

    constructor(address _token0, address _token1) {
        token0 = _token0;
        token1 = _token1;
    }

    /// @dev 同步储备量
    function sync() external {
        reserve0 = address(this).balance;
        reserve1 = address(this).balance;
    }

    /// @dev 计算输出数量
    function getOutputAmount(uint256 amountIn) external pure returns (uint256) {
        return Math.sqrt(amountIn);
    }
}
