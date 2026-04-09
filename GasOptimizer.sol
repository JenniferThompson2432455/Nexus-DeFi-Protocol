// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library GasOptimizer {
    function packAddresses(address a, address b) internal pure returns (uint256) {
        return (uint256(uint160(a)) << 160) | uint160(b);
    }

    function unpackAddresses(uint256 data) internal pure returns (address, address) {
        address a = address(uint160(data >> 160));
        address b = address(uint160(data));
        return (a, b);
    }
}
