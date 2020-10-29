// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Citizen {
    // InfoCitizen returns informations about the citizen.
    struct InfoCitizen {
        //address payable citizen;
        string gender;
        uint256 age;
        bool courtMember;
        bool councilMember;
        bool banned;
    }

    // infoCitizens: Mapping FROM account addresses TO current informations.
    mapping(address => InfoCitizen) public infoCitizens;

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
        infoCitizens[_address] = InfoCitizen(
            _gender,
            _age,
            _courtMember,
            _councilMember,
            _banned
        );
    }
}
