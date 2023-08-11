// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;

import {DelegateTokenStructs as Structs} from "src/libraries/DelegateTokenStructs.sol";

interface IDelegateFlashloan {
    error InvalidFlashloan();

    /**
     * @dev Receive a delegate flashloan.
     * @param initiator caller of the flashloan
     * @param flashInfo struct
     * @return The keccak256 hash of "IDelegateFlashloan.onFlashloan"
     */
    function onFlashloan(address initiator, Structs.FlashInfo calldata flashInfo) external payable returns (bytes32);
}