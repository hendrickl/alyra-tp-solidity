// Harry : 0x1F4FDad26cfe9636ADB5595A3814A25e892A9326
// Tracy : 0xF034a2AA883D2909AF9B3c7406ed01d6a2dF80ca
// Mum : 0x6C97b80D51F0d13744419c48a9045456c82f14dA
// State : 0x65c2c71FB6b78d07dc1Adc81ecdaC7983A5572D9
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "ERCcitizen.sol";

contract Citizen {
    // ownerCitizen: Address of the owner, used for administrative and sensitive function.
    address public ownerCitizen;

    // peopleCount and _step accounts the population.
    uint256 public peopleCount;

    // InfoCitizen returns community informations about the citizen.
    struct InfoCitizen {
        uint256 id;
        bool courtMember;
        bool councilMember;
        string companyMember;
    }

    // Identity returns the identity the citizen.
    struct Identity {
        string firstName;
        string lastName;
        string gender;
        uint256 age;
        string location;
    }

    // infoCitizens: Mapping FROM account addresses TO current administrative informations.
    mapping(address => InfoCitizen) public infoCitizens;

    // idCitizens: Mapping FROM an id TO the identity of a citizen.
    mapping(uint256 => Identity) public idCitizens;

    // _balancesCitizens: Mapping FROM account addresses TO current balance.
    mapping(address => uint256) public balancesCitizens;

    constructor() public {
        ownerCitizen = 0x65c2c71FB6b78d07dc1Adc81ecdaC7983A5572D9;
        peopleCount = 0;
    }

    // A modifier for checking if the `msg.sender` is the owner.
    modifier onlyOwnerCitizen {
        require(
            msg.sender == ownerCitizen,
            "Citizen: Only owner can perform this action"
        );
        _;
    }

    // addCitizen() adds a new citizen.
    function addCitizen(
        address _address,
        bool _courtMember,
        bool _councilMember,
        string memory _companyMember
    ) public onlyOwnerCitizen() {
        peopleCount += 1;
        infoCitizens[_address] = InfoCitizen(
            peopleCount,
            _courtMember,
            _councilMember,
            _companyMember
        );
    }

    // delCitizen() deletes a citizen.

    // mapCitizen() sets 100 CTZ in the amount of the welcoming.
    function mapCitizen(address _address) public onlyOwnerCitizen {
        balancesCitizens[_address] = 100;
    }
}
