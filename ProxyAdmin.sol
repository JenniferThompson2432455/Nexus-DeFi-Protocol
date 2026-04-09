// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Ownable.sol";

contract ProxyAdmin is Ownable {
    address public proxy;

    event ProxyUpgraded(address newImplementation);

    constructor(address _proxy) {
        proxy = _proxy;
    }

    function upgradeProxy(address newImplementation) external onlyOwner {
        proxy = newImplementation;
        emit ProxyUpgraded(newImplementation);
    }
}
