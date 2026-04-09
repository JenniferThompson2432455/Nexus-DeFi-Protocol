// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Ownable.sol";
import "./ReentrancyGuard.sol";
import "./SafeMath.sol";

contract Vault is Ownable, ReentrancyGuard {
    using SafeMath for uint256;

    mapping(address => uint256) public deposits;
    uint256 public totalDeposits;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    function deposit() external payable nonReentrant {
        require(msg.value > 0, "Zero deposit");
        deposits[msg.sender] = deposits[msg.sender].add(msg.value);
        totalDeposits = totalDeposits.add(msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external nonReentrant {
        require(deposits[msg.sender] >= amount, "Insufficient balance");
        deposits[msg.sender] = deposits[msg.sender].sub(amount);
        totalDeposits = totalDeposits.sub(amount);
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }
}
