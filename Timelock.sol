// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Ownable.sol";

contract Timelock is Ownable {
    uint256 public delay = 2 days;
    mapping(bytes32 => uint256) public queue;

    event TransactionQueued(bytes32 txId);
    event TransactionExecuted(bytes32 txId);

    function queueTransaction(address target, uint256 value, bytes calldata data) external onlyOwner returns (bytes32) {
        bytes32 txId = keccak256(abi.encode(target, value, data));
        queue[txId] = block.timestamp + delay;
        emit TransactionQueued(txId);
        return txId;
    }

    function executeTransaction(address target, uint256 value, bytes calldata data) external onlyOwner {
        bytes32 txId = keccak256(abi.encode(target, value, data));
        require(block.timestamp >= queue[txId], "Not ready");
        (bool success,) = target.call{value: value}(data);
        require(success, "Tx failed");
        emit TransactionExecuted(txId);
    }
}
