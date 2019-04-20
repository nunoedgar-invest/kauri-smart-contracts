pragma solidity ^0.5.6;

/**
 * GroupI defines the contract interface and all methods that can be executed from outside (ABI)
 */

interface GroupI
{
    ////////////////////////////////////////////////////////////////////
    // CREATE GROUP
    ////////////////////////////////////////////////////////////////////

    function prepareCreateGroup(
        bytes32 _metadataLocator, 
        bytes32[] calldata _secretHashes,
        uint8[] calldata _assignedRoles,
        uint256 _nonce
    ) 
        external 
        view 
        returns (bytes32);

    /**
     * [META-TX] createGroup
     * Transaction function to create a group where the transaction sender only acts as a middle-man 
     * (meta-tx relayer) and the original sender is recovered from the signature
     */

    function createGroup(
        bytes32 _metadataLocator, 
        bytes32[] calldata _secretHashes,
        uint8[] calldata _assignedRoles,
        bytes calldata _signature, 
        uint256 _nonce
    ) 
        external 
        returns (bool);

    /**
     * [DIRECT] createGroup
     * Transaction function to create a group where there is no middle-man
     * (transaction sender = original sender)
     */

    function createGroup(
        bytes32 _metadataLocator,
        bytes32[] calldata _secretHashes,
        uint8[] calldata _assignedRoles
    )
        external
        returns (bool);

    ////////////////////////////////////////////////////////////////////
    // INVITATION 
    ////////////////////////////////////////////////////////////////////

    /**
     * [META-TX] prepareInvitation
     * View function that generates a unique method call message for 'storeInvitation' in order to be 
     * signed and sent to the relayer to identify original sender using ecrecover.
     */

    function prepareInvitation(
        uint256 _groupId, 
        uint8 _role, 
        bytes32 _secretHash, 
        uint256 _nonce
    )
        external
        view 
        returns (bytes32);

    /**
     * [META-TX] storeInvitation
     * Transaction function to store an invitation where the transaction sender only acts as a middle-man
     * (meta-tx relayer) and the original sender is recovered from the signature.
     */

    function storeInvitation(
        uint256 _groupId,
        uint8 _role,
        bytes32 _secretHash,
        bytes calldata _signature,
        uint256 _nonce
    )
        external
        returns (bool);

    /**
     * [DIRECT] storeInvitation
     * Transaction function to store an invitation where there is no middle-man (tx sender = original sender)
     */

    function storeInvitation(
        uint256 _groupId,
        uint8 _role,
        bytes32 _secretHash
    )
        external
        returns (bool);

    ////////////////////////////////////////////////////////////////////
    // REVOKE INVITATION
    ////////////////////////////////////////////////////////////////////

    /**
     * [META-TX] prepareRevokeInvitation
     * View function generating a unique method call message to be signed and sent to the relayer
     * so we can identify the original sender using ecrecover.
     */

    function prepareRevokeInvitation(
        uint256 _groupId,
        bytes32 _secretHash,
        uint256 _nonce   
    )
        external
        view 
        returns (bytes32);

    /**
     * [META-TX] revokeInvitation
     * Transaction function to store an invitation where the transaction sender only acts as a middle-man 
     * (meta-tx relayer) and the original sender is recovered from the signature
     */

    function revokeInvitation(
        uint256 _groupId,
        bytes32 _secretHash,
        bytes calldata _signature,
        uint256 _nonce   
    )
        external
        returns (bool);

    /**
     * [DIRECT] revokeInvitation
     * Transaction function to store an invitation where there is no middle-man (tx sender = original sender)
     */
    
    function revokeInvitation(
        uint256 _groupId,
        bytes32 _secretHash
    )
        external
        returns (bool);

    ////////////////////////////////////////////////////////////////////
    // ACCEPT INVITATION
    ////////////////////////////////////////////////////////////////////

    function prepareAcceptInvitationCommit(
        uint256 _groupId,
        bytes32 _addressSecretHash,
        uint256 _nonce
    )
        external
        view 
        returns (bytes32);

    /**
     * [META-TX] acceptInvitationCommit
     * 
     * 
     */

    function acceptInvitationCommit(
        uint256 _groupId, 
        bytes32 _addressSecretHash, 
        bytes calldata _signature, 
        uint256 _nonce
    )
        external
        returns (bool);

    /**
     * [META-TX] acceptInvitationCommit
     * 
     * 
     */

    function acceptInvitationCommit(
        uint256 _groupId, 
        bytes32 _addressSecretHash
    )
        external
        returns (bool);

    /**
     * [DIRECT] acceptInvitationCommit  
     */

    function acceptInvitation(
        address _sender,
        uint256 _groupId,
        bytes32 _secret
    )
        external
        returns (bool);

    ////////////////////////////////////////////////////////////////////
    // REMOVE_MEMBER
    ////////////////////////////////////////////////////////////////////

    /**
     * [META-TX] prepareRemoveMember
     * 
     * 
     */

    function prepareRemoveMember(
        uint256 _groupId,
        address _accountToRemove,
        uint256 _nonce
    )
        external
        view
        returns (bytes32);

    /**
     * [META-TX] removeMember
     * 
     * 
     */

    function removeMember(
        uint256 _groupId,
        address _acountToRemove,
        bytes calldata _signature,
        uint256 _nonce
    )
        external
        returns (bool);

    ////////////////////////////////////////////////////////////////////
    // CHANGE_MEMBER
    ////////////////////////////////////////////////////////////////////

    /**
     * [META-TX] prepareChangeMemberRole
     * 
     * 
     */

    function prepareChangeMemberRole(
        uint256 _groupId,
        address _accountToChange,
        uint8 _role,
        uint256 _nonce
    )
        external
        view
        returns (bytes32);

    /**
     * [META-TX] changeMemberRole
     * 
     * 
     */

    function changeMemberRole(
        uint256 _groupId,
        address _accountToChange,
        uint8 _newRole,
        bytes calldata _signature,
        uint256 _nonce
    )
        external
        returns (bool);

    ////////////////////////////////////////////////////////////////////
    // EVENTS
    ////////////////////////////////////////////////////////////////////

    event GroupCreated(
        uint256 indexed groupId, address indexed groupOwner, bytes32 metadataLocator);

    event MemberAdded(
        address indexed member, uint256 indexed groupId, uint8 indexed role);
    event MemberRemoved(
        uint256 indexed groupId, address indexed member, uint8 indexed role);
    event MemberRoleChanged(
        uint256 indexed groupId, address indexed member, uint8 indexed newRole, uint8 oldRole);

    event InvitationPending(
        uint256 indexed groupId, uint8 indexed role, bytes32 secretHash);
    event InvitationRevoked(
        uint256 indexed groupId, uint8 indexed role, bytes32 secretHash);
    event AcceptCommitted(
        uint256 indexed groupId, bytes32 indexed addressSecretHash);

}
