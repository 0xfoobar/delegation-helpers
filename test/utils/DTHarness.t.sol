// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.21;

import {DelegateToken} from "src/DelegateToken.sol";
import {IDelegateRegistry} from "delegate-registry/src/IDelegateRegistry.sol";

/// Harness for DelegateToken that exposes internal methods
contract DTHarness is DelegateToken {
    function exposedSlotUint256(uint256 slotNumber) external view returns (uint256 data) {
        assembly {
            data := sload(slotNumber)
        }
    }

    constructor(address delegateRegistry_, address principalToken_, string memory basURI_, address initialMetadataOwner)
        DelegateToken(delegateRegistry_, principalToken_, basURI_, initialMetadataOwner)
    {
        // Initialize info struct with test info
        uint256[3] memory testInfo = [uint256(1), uint256(2), uint256(3)];
        delegateTokenInfo[0] = testInfo;
    }

    function exposedDelegateTokenInfo(uint256 delegateTokenId, uint256 position) external view returns (uint256) {
        return delegateTokenInfo[delegateTokenId][position];
    }

    function exposedBalances(address delegateTokenHolder) external view returns (uint256) {
        return balances[delegateTokenHolder];
    }

    function exposedTransferByType(address from, uint256 delegateTokenId, uint256 registryHash, address to, address underlyingContract) external {
        _transferByType(from, delegateTokenId, registryHash, to, underlyingContract);
    }

    function exposedPullAndCheckByType(IDelegateRegistry.DelegationType underlyingType, uint256 underlyingAmount, address underlyingContract, uint256 underlyingTokenId)
        external
    {
        return _pullAndCheckByType(underlyingType, underlyingAmount, underlyingContract, underlyingTokenId);
    }

    function exposedCreateByType(
        IDelegateRegistry.DelegationType underlyingType,
        uint256 delegateTokenId,
        address delegateTokenTo,
        uint256 underlyingAmount,
        address underlyingContract,
        bytes32 underlyingRights,
        uint256 underlyingTokenId
    ) external {
        _createByType(underlyingType, delegateTokenId, delegateTokenTo, underlyingAmount, underlyingContract, underlyingRights, underlyingTokenId);
    }

    function exposedWithdrawByType(
        address recipient,
        bytes32 registryLocation,
        uint256 delegateTokenId,
        bytes32 delegationHash,
        address delegateTokenHolder,
        IDelegateRegistry.DelegationType delegationType,
        address underlyingContract,
        bytes32 underlyingRights
    ) external {
        _withdrawByType(recipient, registryLocation, delegateTokenId, delegationHash, delegateTokenHolder, delegationType, underlyingContract, underlyingRights);
    }

    function exposedWriteApproved(uint256 delegateTokenId, address approved) external {
        _writeApproved(delegateTokenId, approved);
    }

    function exposedWriteExpiry(uint256 delegateTokenId, uint256 expiry) external {
        _writeExpiry(delegateTokenId, expiry);
    }

    function exposedReadApproved(uint256 delegateTokenId) external view returns (address) {
        return _readApproved(delegateTokenId);
    }

    function exposedReadExpiry(uint256 delegateTokenId) external view returns (uint256) {
        return _readExpiry(delegateTokenId);
    }

    function exposedBuildTokenURI(address tokenContract, uint256 delegateTokenId, uint256 expiry, address principalOwner) external view returns (string memory) {
        return _buildTokenURI(tokenContract, delegateTokenId, expiry, principalOwner);
    }
}
