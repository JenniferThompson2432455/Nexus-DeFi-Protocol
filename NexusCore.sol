// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Ownable.sol";
import "./ReentrancyGuard.sol";
import "./Pausable.sol";

/**
 * @title NexusCore
 * @dev Nexus DeFi协议核心控制器，管理全协议状态、模块初始化与紧急操作
 */
contract NexusCore is Ownable, ReentrancyGuard, Pausable {
    bool public protocolActive;
    address public immutable factory;
    address public immutable router;

    event ProtocolStatusUpdated(bool status);

    constructor(address _factory, address _router) {
        require(_factory != address(0) && _router != address(0), "Invalid addresses");
        factory = _factory;
        router = _router;
        protocolActive = true;
    }

    /// @dev 切换协议全局状态
    function toggleProtocol() external onlyOwner {
        protocolActive = !protocolActive;
        emit ProtocolStatusUpdated(protocolActive);
    }

    /// @dev 紧急暂停全协议
    function emergencyPause() external onlyOwner whenNotPaused {
        _pause();
    }

    /// @dev 解除协议暂停
    function emergencyUnpause() external onlyOwner whenPaused {
        _unpause();
    }

    /// @dev 校验协议是否可用
    modifier protocolEnabled() {
        require(protocolActive, "Protocol is disabled");
        _;
    }
}
