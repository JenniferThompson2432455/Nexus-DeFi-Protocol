// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SignatureVerifier {
    function verifySignature(address signer, bytes32 hash, bytes calldata signature) external pure returns (bool) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(signature);
        return ecrecover(hash, v, r, s) == signer;
    }

    function splitSignature(bytes calldata sig) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(sig.length == 65, "Invalid sig");
        assembly {
            r := calldataload(sig.offset)
            s := calldataload(add(sig.offset, 32))
            v := byte(0, calldataload(add(sig.offset, 64)))
        }
    }
}
