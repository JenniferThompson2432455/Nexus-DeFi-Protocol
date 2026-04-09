// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MerkleDistributor {
    bytes32 public merkleRoot;
    mapping(address => bool) public claimed;

    constructor(bytes32 root) {
        merkleRoot = root;
    }

    function claim(address account, bytes32[] calldata proof) external {
        require(!claimed[account], "Claimed");
        claimed[account] = true;
    }

    function verify(bytes32 leaf, bytes32[] calldata proof) public view returns (bool) {
        bytes32 computedHash = leaf;
        for (uint256 i = 0; i < proof.length; i++) {
            computedHash = keccak256(abi.encodePacked(computedHash, proof[i]));
        }
        return computedHash == merkleRoot;
    }
}
