// Harry : 0x1F4FDad26cfe9636ADB5595A3814A25e892A9326
// Tracy : 0xF034a2AA883D2909AF9B3c7406ed01d6a2dF80ca
// Mum : 0x6C97b80D51F0d13744419c48a9045456c82f14dA
// State : 0x65c2c71FB6b78d07dc1Adc81ecdaC7983A5572D9
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "ERCcitizen.sol";

contract Citizen {
    // ownerCitizen: address of the owner, used for administrative and sensitive function.
    address public ownerCitizen;

    // addressCitizen: address of the current citizen
    address private _addressCitizen;

    // peopleCount is a counter of the population.
    // peopleCount is also an citizen id.
    uint256 public peopleCount;

    // StatusCtn returns status informations about the citizen.
    struct StatusCtn {
        uint256 id;
        bool courtMember;
        bool councilMember;
        string companyMember;
    }

    // Identity returns the identity of the citizen.
    struct Identity {
        string firstName;
        string lastName;
        string gender;
        uint256 age;
        string location;
    }

    // statusCitizens: Mapping FROM account addresses TO current administrative status.
    mapping(address => StatusCtn) public statusCitizens;

    // idtCitizens: Mapping FROM an id TO the identity of a citizen.
    mapping(uint256 => Identity) public idtCitizens;

    // citizenId: Mapping FROM an id (peopleCount) TO the address affiliated with.
    mapping(uint256 => address) public citizenId;

    // balancesCitizens: Mapping FROM account addresses TO current balance.
    mapping(address => uint256) public balancesCitizens;

    constructor() public {
        ownerCitizen = 0x65c2c71FB6b78d07dc1Adc81ecdaC7983A5572D9;
        peopleCount = 0;
        citizenId[peopleCount] = address(_addressCitizen);
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
    // addCitizen() uses the struct InfoCitizen and fill the mapping infoCitizens.
    function addCitizen(
        address _address,
        bool _courtMember,
        bool _councilMember,
        string memory _companyMember
    ) public onlyOwnerCitizen() {
        peopleCount += 1;
        statusCitizens[_address] = StatusCtn(
            peopleCount,
            _courtMember,
            _councilMember,
            _companyMember
        );
    }

    modifier onlyCitizen {
        require(
            msg.sender == address(_addressCitizen),
            "Citizen: Only citizen can perform this action"
        );
        _;
    }

    // register() adds the identity of the citizen.
    // register() uses the struct Identity and fills the mapping idCitizens.
    function register(
        string memory _firstName,
        string memory _lastName,
        string memory _gender,
        uint256 _age,
        string memory _location
    ) public onlyCitizen {
        idtCitizens[peopleCount] = Identity(
            _firstName,
            _lastName,
            _gender,
            _age,
            _location
        );
    }

    // mapCitizen() sets 100 CTZ in the amount of the welcoming.
    function mapCitizen(address _address) public onlyOwnerCitizen {
        balancesCitizens[_address] = 100;
    }
}
