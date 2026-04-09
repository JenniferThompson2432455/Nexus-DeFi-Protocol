// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Ownable.sol";

contract AccessControl is Ownable {
    mapping(bytes32 => mapping(address => bool)) public roles;

    event RoleGranted(bytes32 role, address account);
    event RoleRevoked(bytes32 role, address account);

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN");
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR");

    constructor() {
        roles[ADMIN_ROLE][msg.sender] = true;
    }

    function grantRole(bytes32 role, address account) external onlyOwner {
        roles[role][account] = true;
        emit RoleGranted(role, account);
    }

    function revokeRole(bytes32 role, address account) external onlyOwner {
        roles[role][account] = false;
        emit RoleRevoked(role, account);
    }

    modifier onlyRole(bytes32 role) {
        require(roles[role][msg.sender], "No role");
        _;
    }
}
