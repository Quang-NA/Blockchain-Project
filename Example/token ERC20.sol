1000000, "Bitcoin", "BTC", 18

pragma solidity ^0.4.11;

contract MyToken {
    event Transfer(address _from, address _to, uint256 _value);
//    event Approve(address indexed _ower, address indexed _spender, uint256 _value);
    mapping (address => uint256) public balance;
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    
    function MyToken(uint256 initialSupply, string tokenName, string tokenSymbol, uint8 decimalUnits) {
        balance[msg.sender] = initialSupply;
        name = tokenName;
        symbol = tokenSymbol;
        decimals = decimalUnits;
        totalSupply = initialSupply;
    } 
    
    function totalSupply() constant returns (uint256) {
        return totalSupply;
    }
    
    function balanceOf(address _ower) constant returns (uint256) {
        return balance[_ower];
    }
    
    function transfer(address _to, uint256 _value) returns (bool) {
        require(balance[msg.sender] >= _value);
        require(balance[_to] + _value >= balance[_to]);
        balance[msg.sender] -= _value;
        balance[_to] += _value;
        Transfer(msg.sender, _to, _value);
    }
    
    function name() constant returns (string) {
        return name;
    }
    
    function symbol() constant returns (string) {
        return symbol;
    }
    
    function decimals() constant returns (uint8) {
        return decimals;
    }
    
}