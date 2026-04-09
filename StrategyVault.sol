// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Vault.sol";
import "./YieldFarming.sol";

contract StrategyVault is Vault {
    YieldFarming public farming;

    constructor(address _farming) {
        farming = YieldFarming(_farming);
    }

    function depositAndFarm() external payable {
        super.deposit{value: msg.value}();
        farming.stake(msg.value);
    }
}
