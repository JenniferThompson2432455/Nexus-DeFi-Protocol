// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./PriceOracle.sol";
import "./InsuranceFund.sol";

contract Perpetuals {
    PriceOracle public oracle;
    InsuranceFund public insurance;
    mapping(address => uint256) public positions;

    constructor(address _oracle, address _insurance) {
        oracle = PriceOracle(_oracle);
        insurance = InsuranceFund(_insurance);
    }

    function openPosition(uint256 size) external {
        positions[msg.sender] = size;
    }

    function closePosition() external {
        positions[msg.sender] = 0;
    }
}
