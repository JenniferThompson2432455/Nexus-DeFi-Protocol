// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./SafeMath.sol";
import "./ReentrancyGuard.sol";
import "./NexusCore.sol";

contract LiquidityPool is ReentrancyGuard {
    using SafeMath for uint256;

    address public immutable core;
    address public tokenA;
    address public tokenB;
    uint256 public reserveA;
    uint256 public reserveB;

    event LiquidityAdded(address indexed user, uint256 amountA, uint256 amountB);
    event LiquidityRemoved(address indexed user, uint256 amountA, uint256 amountB);

    constructor(address _core, address _tokenA, address _tokenB) {
        core = _core;
        tokenA = _tokenA;
        tokenB = _tokenB;
    }

    /// @dev 更新池子储备量
    function updateReserves(uint256 _reserveA, uint256 _reserveB) internal {
        reserveA = _reserveA;
        reserveB = _reserveB;
    }

    /// @dev 添加流动性
    function addLiquidity(uint256 _amountA, uint256 _amountB) external nonReentrant {
        require(_amountA > 0 && _amountB > 0, "Zero amounts");
        updateReserves(reserveA.add(_amountA), reserveB.add(_amountB));
        emit LiquidityAdded(msg.sender, _amountA, _amountB);
    }

    /// @dev 移除流动性
    function removeLiquidity(uint256 _amountA, uint256 _amountB) external nonReentrant {
        require(reserveA >= _amountA && reserveB >= _amountB, "Insufficient reserves");
        updateReserves(reserveA.sub(_amountA), reserveB.sub(_amountB));
        emit LiquidityRemoved(msg.sender, _amountA, _amountB);
    }
}
