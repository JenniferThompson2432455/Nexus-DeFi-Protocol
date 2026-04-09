// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./NexusToken.sol";
import "./SafeMath.sol";

contract VotingEscrow {
    using SafeMath for uint256;

    NexusToken public token;
    mapping(address => uint256) public balanceOf;

    constructor(address _token) {
        token = NexusToken(_token);
    }

    function lock(uint256 amount) external {
        token.transferFrom(msg.sender, address(this), amount);
        balanceOf[msg.sender] = balanceOf[msg.sender].add(amount);
    }

    function unlock() external {
        uint256 amount = balanceOf[msg.sender];
        balanceOf[msg.sender] = 0;
        token.transfer(msg.sender, amount);
    }
}
