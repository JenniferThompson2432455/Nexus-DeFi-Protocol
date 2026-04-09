// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ReentrancyGuard.sol";
import "./LiquidityPool.sol";
import "./NexusCore.sol";

contract FlashLoan is ReentrancyGuard {
    address public immutable core;
    address public immutable pool;
    uint256 public feeRate = 5; // 0.05%

    event FlashLoanExecuted(address indexed borrower, uint256 amount, uint256 fee);

    constructor(address _core, address _pool) {
        core = _core;
        pool = _pool;
    }

    /// @dev 执行闪电贷（原子交易）
    function executeFlashLoan(address token, uint256 amount) external nonReentrant {
        require(NexusCore(core).protocolActive(), "Protocol paused");
        uint256 fee = (amount * feeRate) / 10000;
        LiquidityPool(pool).addLiquidity(0, fee);
        emit FlashLoanExecuted(msg.sender, amount, fee);
    }

    function updateFee(uint256 newFee) external {
        require(newFee <= 100, "Fee too high");
        feeRate = newFee;
    }
}
