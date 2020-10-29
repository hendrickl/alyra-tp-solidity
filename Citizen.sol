// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Citizen {
    // _infoCitizen: Mapping FROM account addresses TO current informations.
    mapping(address => InfoCitizen) private _infoCitizen;

    // InfoCitizen returns informations about the citizen.
    struct InfoCitizen {
        string gender;
        uint256 age;
        bool courtMember;
        bool councilMember;
        bool banned;
    }

    // _citizenAccount: Address of the citizen.
    address public citizenAccount;

    // _balancesCitizens: Mapping FROM account addresses TO current balance.
    mapping(address => uint256) public balancesCitizens;

    constructor() public {}

    // setCitizen() adds a new citizen.
    function setCitizen(
        address _address,
        string memory _gender,
        uint8 _age,
        bool _courtMember,
        bool _councilMember,
        bool _banned
    ) public {
        _infoCitizen[_address] = InfoCitizen(
            _gender,
            _age,
            _courtMember,
            _councilMember,
            _banned
        );
    }

    // getCitizen() returns a informations struct about the account.
    function getCitizen(address _address) public view {
        _infoCitizen[_address];
    }
}
