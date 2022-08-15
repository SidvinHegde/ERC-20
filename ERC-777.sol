// This is an improvement over ERC-20 standard
// The first difference is the delegated transfer. In ERC-20 a third party addresses can be allowed to transafer tokens only upto a certain amount.
// In ERC-777 third party addresses also called operators are not limited by a specific amount of tokens. They can transfer all the tokens.

// The second difference is the hook. There are two types of hooks send and receive hook. The receive hook allows to call a function in the receiving addresses(This allows a receiving address to react to incoming transfers)
// The send hook allows the token owner to cancel a transfer by reverting the transaction 

pragma solidity 0.5.3;

interface ERC777token {
	function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function totalSupply() external view returns (uint256);
    function balanceOf(address holder) external view returns (uint256);
    function granularity() external view returns (uint256); // decimals in ERC-20

    function defaultOperators() external view returns (address[] memory);
    function isOperatorFor( address operator, address holder) external view returns (bool);
    function authorizeOperator(address operator) external;
    function revokeOperator(address operator) external;

    function send(address to, uint256 amount, bytes calldata data) external;  // Transfer in ERC-20
    function operatorSend(address from, address to, uint256 amount, bytes calldata data, bytes calldata opearatorData) external;

    function burn(uint256 amount, bytes calldata data) external; // function to burn token
    function operatorBurn(address from, uint256 amount, bytes calldata data, bytes calldata operatorData) external; // function to burn token 

    event Sent(
    	address indexed operator, 
    	address indexed from, 
    	address indexed to, 
    	uint256 amount, 
    	bytes data, 
    	bytes operatorData
    );

    event Minted(
    	address indexed operator,  
    	address indexed to, 
    	uint256 amount, 
    	bytes data, 
    	bytes operatorData
    );

    event Burned(
    	address indexed operator,  
    	address indexed from, 
    	uint256 amount, 
    	bytes data, 
    	bytes operatorData
    );

    event AuthorizedOperator(
    	address indexed operator,
    	address indexed holder
    );

    event RevokedOperator(
    	address indexed operator, 
    	address indexed holder
    );
}

function tokensToSend(   // send hook (has to be implemented by the sender)
	address operator,
	address from,
	address to,
	uint256 amount,
	bytes calldata userData,
	bytes calldata opearatorData
) external

// send and receivehook are inplemented inside the sender and the receiver contract

interface ERC777TokenRecipient {
	function tokenReceived(
		address operator,
		address from,
		address to,
		uint256 amount,
		bytes calldata data,
		bytes calldata operatorData
	) external;                           // if the recipient has refuse the incoming tokens this has to be used
										  // this interface has to be registered in the ERC-1820 registry
										   
}
