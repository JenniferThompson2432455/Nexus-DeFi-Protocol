// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./VotingEscrow.sol";
import "./Timelock.sol";
import "./Ownable.sol";

contract Governance is Ownable {
    struct Proposal {
        address target;
        uint256 value;
        bytes data;
        uint256 startTime;
        uint256 endTime;
        uint256 forVotes;
        uint256 againstVotes;
        bool executed;
    }

    uint256 public proposalCount;
    mapping(uint256 => Proposal) public proposals;
    address public votingEscrow;
    address public timelock;

    event ProposalCreated(uint256 id, address target);
    event VoteCast(uint256 id, address voter, bool support);

    constructor(address _ve, address _timelock) {
        votingEscrow = _ve;
        timelock = _timelock;
    }

    function createProposal(address target, uint256 value, bytes calldata data) external {
        require(VotingEscrow(votingEscrow).balanceOf(msg.sender) > 0, "No voting power");
        proposalCount++;
        Proposal storage p = proposals[proposalCount];
        p.target = target;
        p.value = value;
        p.data = data;
        p.startTime = block.timestamp;
        p.endTime = block.timestamp + 7 days;
        emit ProposalCreated(proposalCount, target);
    }
}
