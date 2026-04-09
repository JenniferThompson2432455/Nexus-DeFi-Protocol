// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MultisigWallet {
    address[] public owners;
    uint256 public required;
    mapping(uint256 => mapping(address => bool)) public confirmations;

    struct Transaction {
        address to;
        uint256 value;
        bool executed;
    }

    Transaction[] public transactions;

    constructor(address[] memory _owners, uint256 _required) {
        require(_owners.length > 0 && _required > 0 && _required <= _owners.length);
        owners = _owners;
        required = _required;
    }

    function submitTransaction(address to, uint256 value) external returns (uint256) {
        transactions.push(Transaction(to, value, false));
        return transactions.length - 1;
    }
}
