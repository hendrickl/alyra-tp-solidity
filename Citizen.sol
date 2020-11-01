// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "ERCcitizen.sol";

contract Citizen {
    // _ownerCitizen: address of the owner, used for administrative and sensitive function.
    address private _ownerCitizen;

    // _addressCitizen: address of a citizen registered by owner.
    address private _addressCitizen;

    // peopleCount is a counter of the population.
    // peopleCount is also a citizen ID.
    uint256 private _peopleCount;

    uint256 private _id;

    // StatusCtn returns status informations about the citizen.
    struct StatusCtn {
        uint256 peopleCount;
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
    // addressCitizen => struct StatusCtn
    mapping(address => StatusCtn) public statusCitizens;

    // idtCitizens: Mapping FROM an ID TO the identity of a citizen.
    // ID => struct Identity
    mapping(uint256 => Identity) public idtCitizens;

    // citizenAddr: Mapping FROM a ID TO the address affiliated with.
    // ID => addressCitizen
    mapping(uint256 => address) public citizenAddr;

    // citizenId: Mapping FROM a registered citizen address TO an id.
    // addressCitizen => ID
    mapping(address => uint256) public citizenId;

    // balancesCitizens: Mapping FROM account addresses TO current balance.
    // addressCitizen => balanceCitizen
    mapping(address => uint256) public balancesCitizens;

    constructor() public {
        _ownerCitizen = address(0x65c2c71FB6b78d07dc1Adc81ecdaC7983A5572D9);
        citizenAddr[_peopleCount] = _addressCitizen;
        citizenId[_addressCitizen] = _peopleCount;
        _peopleCount = 0;
    }

    // A modifier for checking if the `msg.sender` is the owner.
    modifier onlyOwnerState {
        require(
            msg.sender == _ownerCitizen,
            "Citizen: Only owner can perform this action"
        );
        _;
    }

    // A modifier for checking if the `msg.sender` is a citizen.
    modifier onlyOwnerCitizen {
        require(
            citizenAddr[_peopleCount] == msg.sender,
            "Citizen: Only citizen can perform this action"
        );
        _;
    }

    // setCitizen() sets a new citizen.
    // setCitizen() uses the struct InfoCitizen and fills the mapping infoCitizens.
    function setCitizen(
        address _address,
        bool _courtMember,
        bool _councilMember,
        string memory _companyMember
    ) public onlyOwnerState() {
        _addressCitizen = _address;
        _peopleCount += 1;
        citizenId[_address] = _peopleCount;
        citizenAddr[_peopleCount] = _address;
        statusCitizens[_address] = StatusCtn(
            _peopleCount,
            _courtMember,
            _councilMember,
            _companyMember
        );
        // +EVENT
    }

    // register() adds the identity of the citizen.
    // register() uses the struct Identity and fills the mapping idCitizens.
    function register(
        uint256 _idCtn,
        string memory _firstName,
        string memory _lastName,
        string memory _gender,
        uint256 _age,
        string memory _location
    ) public onlyOwnerCitizen {
        _id = _idCtn;
        idtCitizens[_id] = Identity(
            _firstName,
            _lastName,
            _gender,
            _age,
            _location
        );
        // +EVENT
    }

    // allCitizens() returns the number of citizens.
    function allCitizens() public view returns (uint256) {
        return _peopleCount;
    }

    // transferCtz() sends 100 CTZ in the account of the welcomed citizen.
    function transferCtz(address _address) public onlyOwnerState {
        balancesCitizens[_address] = 100;
    }
}
