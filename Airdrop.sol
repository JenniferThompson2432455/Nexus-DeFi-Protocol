// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./NexusToken.sol";
import "./Ownable.sol";

contract Airdrop is Ownable {
    NexusToken public token;
    mapping(address => bool) public claimed;

    constructor(address _token) {
        token = NexusToken(_token);
    }

    function claim() external {
        require(!claimed[msg.sender], "Already claimed");
        claimed[msg.sender] = true;
        token.transfer(msg.sender, 100 * 10**18);
    }
}
