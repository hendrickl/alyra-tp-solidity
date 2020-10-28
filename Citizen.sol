// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Citizen {
    // CitiMember returns informations about the citizen
    struct CitiMember {
        address account;
        string gender;
        bool courtMember;
        bool councilMember;
        bool banned;
    }

    // _memberAddress: Address of the member
    address public _memberAddress;

    // _balancesMembers: Mapping FROM account addresses TO current balance.
    mapping(address => uint256) private _balancesMembers;

    constructor() public {}

    // setMember() adds a new member
    function setMember() public {}
}
