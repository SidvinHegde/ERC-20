pragma solidity ^0.8.10;

interface IER20 {

    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(address spender, address recipient, uint amount) external return (bool);

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);

}

contract ERC20 is IERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name = "Test";
    string symbol = "TEST"; // Important for trading in exchanges
    uint8 public decimals = 18; // describes the granularity of the token

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    } // Returns the account balance of _owner

    function transfer(address recipient, uint _value external returns (bool) {
        balanceOf[msg.sender] -= _value;
        balanceOf[recipient] += _value;
        emit Transfer(msg.sender, recipient, _value);
        return true;
    } // Transfers _value amount of tokens to recipient address and fires Transfer event.

    function approve(address spender, uint _value) external returns (bool) {
        allowance[msg.sender][spender] = _value;
        emit Approval(msg.sender, spender, _value);
        return true;
    } // Allows spender to withdraw from your account multiple times upto _value.

    function transferFrom (address sender, address recipient, uint _value) external returns (bool) {
        allowance[sender][msg.sender] -= _value;
        balanceOf[sender] -= _value;
        balanceOf[recipient] += _value;
        emit Transfer(sender, recipient, _value);
        return true;
    } // Transfer _value amoount of tokens from sender address to recipient address and fires Transfer event.

    function mint(uint _value) external {
        balanceOf[msg.sender] += _value;
        totalSupply += _value;
        emit Transfer(address(0), msg.sender, _value);
    } 

    function burn(uint _value) external {
        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;
        emit Transfer(msg.sender, address(0), _value);
    }  
}
