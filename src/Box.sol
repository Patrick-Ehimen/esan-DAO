// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Box is Ownable{
    uint256 private value;

    // Emitted when the stored value changes
    /// @param newValue The new value being stored
    event ValueChanged(uint256 newValue);

    // Stores a new value in the contract
    /// @notice Allows the owner to store a new value
    /// @param newValue The new value to store
    function store(uint256 newValue) public onlyOwner {
        value = newValue;
        emit ValueChanged(newValue);
    }

    // Reads the last stored value
    /// @notice Retrieves the last stored value
    /// @return The last stored value
    function retrieve() public view returns (uint256) {
        return value;
    }
}
