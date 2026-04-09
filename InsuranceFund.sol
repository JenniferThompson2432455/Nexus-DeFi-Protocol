// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Ownable.sol";
import "./SafeMath.sol";

contract InsuranceFund is Ownable {
    using SafeMath for uint256;

    uint256 public fundBalance;

    event FundDeposited(uint256 amount);
    event FundUsed(uint256 amount);

    function deposit() external payable {
        fundBalance = fundBalance.add(msg.value);
        emit FundDeposited(msg.value);
    }

    function useFund(uint256 amount) external onlyOwner {
        require(fundBalance >= amount, "Insufficient fund");
        fundBalance = fundBalance.sub(amount);
        emit FundUsed(amount);
    }
}
