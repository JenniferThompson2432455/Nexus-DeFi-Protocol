// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ERC20.sol";
import "./Ownable.sol";

contract NexusToken is ERC20, Ownable {
    uint256 public constant MAX_SUPPLY = 100_000_000 * 10**18;

    constructor() ERC20("Nexus DeFi Token", "NEX") {
        _mint(msg.sender, 10_000_000 * 10**18);
    }

    /// @dev 铸造代币（仅Owner）
    function mint(address to, uint256 amount) external onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "Max supply exceeded");
        _mint(to, amount);
    }

    /// @dev 销毁代币
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
