// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Governor} from "@openzeppelin/contracts/governance/Governor.sol";
import {GovernorSettings} from "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import {GovernorCountingSimple} from "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import {GovernorVotes} from "@openzeppelin/contracts/governance/extensions/GovernorVotes.sol";
import {GovernorVotesQuorumFraction} from
    "@openzeppelin/contracts/governance/extensions/GovernorVotesQuorumFraction.sol";
import {GovernorTimelockControl} from "@openzeppelin/contracts/governance/extensions/GovernorTimelockControl.sol";
import {TimelockController} from "@openzeppelin/contracts/governance/TimelockController.sol";

import {IVotes} from "@openzeppelin/contracts/governance/utils/IVotes.sol";
import {IGovernor} from "@openzeppelin/contracts/governance/IGovernor.sol";

contract MyGovernor is Governor, GovernorSettings, GovernorCountingSimple, GovernorVotes,GovernorVotesQuorumFraction, GovernorTimelockControl {
    /**
     * @dev Initializes the contract setting the token and timelock controller.
     * @param _token The voting token.
     * @param _timelock The timelock controller contract.
     */
    constructor(IVotes _token, TimelockController _timelock)
    Governor("MyGovernor")
    GovernorSettings(1, /* 1 block */ 50400, /* 1 week */ 0)
    GovernorVotes(_token)
    GovernorVotesQuorumFraction(4)
    GovernorTimelockControl(_timelock)
    {}

    // The following functions are overrides required by Solidity.

    /**
     * @dev Returns the voting delay, in blocks.
     */
    function votingDelay() public view override(IGovernor, GovernorSettings) returns (uint256) {
        return super.votingDelay();
    }

    /**
     * @dev Returns the voting period, in blocks.
     */
    function votingPeriod() public view override(IGovernor, GovernorSettings) returns (uint256) {
        return super.votingPeriod();
    }

    /**
     * @dev Returns the quorum required to pass a proposal, based on the block number.
     * @param blockNumber The block number for which to get the quorum.
     */
    function quorum(uint256 blockNumber)
        public
        view
        override(IGovernor, GovernorVotesQuorumFraction)
        returns (uint256)
    {
        return super.quorum(blockNumber);
    }

    /**
     * @dev Returns the state of a proposal.
     * @param proposalId The proposal id.
     */
    function state(uint256 proposalId)
        public
        view
        override(Governor, GovernorTimelockControl)
        returns (ProposalState)
    {
        return super.state(proposalId);
    }

    /**
     * @dev Creates a new proposal.
     * @param targets The proposal targets.
     * @param values The proposal values.
     * @param calldatas The proposal calldatas.
     * @param description The proposal description.
     */
    function propose(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        string memory description
    ) public override(Governor, IGovernor) returns (uint256) {
        return super.propose(targets, values, calldatas, description);
    }

    /**
     * @dev Returns the proposal threshold.
     */
    function proposalThreshold() public view override(Governor, GovernorSettings) returns (uint256) {
        return super.proposalThreshold();
    }

    /**
     * @dev Executes a proposal.
     * @param proposalId The proposal id.
     * @param targets The proposal targets.
     * @param values The proposal values.
     * @param calldatas The proposal calldatas.
     * @param descriptionHash The proposal description hash.
     */
    function _execute(
        uint256 proposalId,
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        bytes32 descriptionHash
    ) internal override(Governor, GovernorTimelockControl) {
        super._execute(proposalId, targets, values, calldatas, descriptionHash);
    }

    /**
     * @dev Cancels a proposal.
     * @param targets The proposal targets.
     * @param values The proposal values.
     * @param calldatas The proposal calldatas.
     * @param descriptionHash The proposal description hash.
     */
    function _cancel(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        bytes32 descriptionHash
    ) internal override(Governor, GovernorTimelockControl) returns (uint256) {
        return super._cancel(targets, values, calldatas, descriptionHash);
    }

    /**
     * @dev Returns the executor address.
     */
    function _executor() internal view override(Governor, GovernorTimelockControl) returns (address) {
        return super._executor();
    }

    /**
     * @dev Checks if the contract supports an interface.
     * @param interfaceId The interface id.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(Governor, GovernorTimelockControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}