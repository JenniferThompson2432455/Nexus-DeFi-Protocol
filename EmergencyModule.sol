// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./NexusCore.sol";
import "./Ownable.sol";

contract EmergencyModule is Ownable {
    NexusCore public immutable core;

    constructor(address _core) {
        core = NexusCore(_core);
    }

    /// @dev 全协议紧急关停
    function fullProtocolShutdown() external onlyOwner {
        core.emergencyPause();
    }

    /// @dev 恢复协议
    function recoverProtocol() external onlyOwner {
        core.emergencyUnpause();
    }
}
