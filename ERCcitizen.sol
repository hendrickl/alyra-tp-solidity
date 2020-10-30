// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract ERCcitizen {
    // _balances: Mapping FROM account addresses TO current balance.
    mapping(address => uint256) private _balances;

    // _allowances: Mapping FROM account addresses TO a mapping FROM spender addresses TO an allowance amount.
    mapping(address => mapping(address => uint256)) private _allowances;

    // _ownerAddress: Address of the owner, used for administrative and sensitive function.
    address payable _ownerAddress;

    // _name: Name of the token
    string private _name;

    // _symbol: Symbol of the token
    string private _symbol;

    // _decimals: Number of decimals the token uses
    // 10 means you have to divide the token amount by 10000000000, to get its user representation.
    uint8 private _decimals;

    // _totalSupply: Total of the token supply
    uint256 private _totalSupply;

    // _cap: Maximum amount of the token supply
    uint256 private _cap;

    constructor(string memory name, string memory symbol) public {
        _ownerAddress = 0x65c2c71FB6b78d07dc1Adc81ecdaC7983A5572D9;
        _balances[address(0x65c2c71FB6b78d07dc1Adc81ecdaC7983A5572D9)] =
            500 *
            10**18;
        _name = name;
        _symbol = symbol;
        _decimals = 18;
        _totalSupply = 5000 * 10**18;
    }

    // getOwner() returns the account of the owner
    function getOwner() public view returns (address) {
        return _ownerAddress;
    }

    // name() returns the name of the token
    function name() public view returns (string memory) {
        return _name;
    }

    // symbol() returns the symbol of the token
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    // decimals() returns the nb of decimals the token uses
    function decimals() public view returns (uint8) {
        return _decimals;
    }

    // totalSupply() returns the amount of tokens in existence
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    // balanceOf() returns the amount of tokens owned by `_account`
    function balanceOf(address _account) public view returns (uint256) {
        return _balances[_account];
    }

    // transfer() moves `_amount` of tokens FROM the caller's account TO `_recipient`.
    // transfer() returns a boolean value indicating whether the operation succeeded.
    function transfer(address _recipient, uint256 _amount)
        public
        returns (bool)
    {
        require(
            _balances[msg.sender] >= _amount,
            "ERCcitizen: transfer amount exceeds balance"
        );
        _balances[msg.sender] -= _amount;
        _balances[_recipient] += _amount;
        emit Transfer(msg.sender, _recipient, _amount);
        return true;
    }

    // approve() sets the `_amount` AS the allowance OF the `_spender` OVER the caller's tokens.
    // approve() returns a boolean value indicating whether the operation succeeded.
    function approve(address _spender, uint256 _amount) public returns (bool) {
        _allowances[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    // This event is emitted when the allowance of a `_spender` for an `_owner` is set by
    // a call to `approve`. `_value` is the new allowance.
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    // allowance() returns the remaining number of tokens that the `_spender` will be allowed
    // to spend on behalf of `_owner` through `transferFrom`. This is zero by default.
    // When approve() or transferFrom() are called : This value changes.
    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256)
    {
        return _allowances[_owner][_spender];
    }

    // transferFrom() moves `_amount` tokens FROM `_sender` TO `_recipient` USING the
    // allowance mechanism.
    // Then `_amount` is deducted from the caller's allowance.
    // transferFrom() returns a boolean value indicating whether the operation succeeded.
    // transferFrom() emits a `Transfer event'.
    function transferFrom(
        address _sender,
        address _recipient,
        uint256 _amount
    ) public returns (bool) {
        require(
            _balances[_sender] >= _amount,
            "ERCcitizen: transfer amount exceeds balance"
        );
        require(
            _allowances[_sender][msg.sender] >= _amount,
            "ERCcitizen: transfer amount exceeds allowance"
        );
        _balances[_sender] -= _amount;
        _balances[_recipient] += _amount;
        _allowances[_sender][msg.sender] -= _amount;
        emit Transfer(_sender, _recipient, _amount);
        return true;
    }

    // This event is emitted when VALUE (`_value`) tokens are moved FROM (`_from`) an account
    // TO (`_to`) another
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}
