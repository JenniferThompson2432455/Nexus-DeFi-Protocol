// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ERC721.sol";
import "./Ownable.sol";

contract NFTPosition is ERC721, Ownable {
    uint256 public tokenId;

    constructor() ERC721("Nexus LP Position", "NLP") {}

    function mint(address to) external returns (uint256) {
        tokenId++;
        _mint(to, tokenId);
        return tokenId;
    }

    function burn(uint256 id) external {
        _burn(id);
    }
}
