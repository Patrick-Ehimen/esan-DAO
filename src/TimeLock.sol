// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TimelockController} from "@openzeppelin/contracts/governance/TimelockController.sol";

contract TimeLock is TimelockController {
    /// @notice Create a new TimeLock contract
    /// @param minDelay How long you have to wait before executing
    /// @param proposers The list of addresses that can propose
    /// @param executors The list of addresses that can execute
    constructor(uint256 minDelay, address[] memory proposers, address[] memory executors)
        TimelockController(minDelay, proposers, executors, msg.sender)
    {}
}