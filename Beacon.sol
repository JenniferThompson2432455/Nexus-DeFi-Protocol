// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Ownable.sol";

contract Beacon is Ownable {
    address public implementation;

    event ImplementationUpdated(address indexed newImpl);

    constructor(address _implementation) {
        implementation = _implementation;
    }

    function updateImplementation(address newImpl) external onlyOwner {
        implementation = newImpl;
        emit ImplementationUpdated(newImpl);
    }
}
