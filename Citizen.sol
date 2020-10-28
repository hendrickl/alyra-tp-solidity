// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Citizen {
    // CitiMember returns informations about the citizen
    struct CitiMember {
        address account;
        string gender;
        bool courtMember;
        bool councilMember;
    }

    constructor() public {}
}
