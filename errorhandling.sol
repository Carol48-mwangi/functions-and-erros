// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SavingsBank {
    mapping(address => uint256) private balances;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Deposit function
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
        assert(balances[msg.sender] >= msg.value);
    }

    // Withdraw function
    function withdraw(uint256 _amount) public {
        require(_amount <= balances[msg.sender], "Insufficient balance");
        require(_amount > 0, "Withdraw amount must be greater than zero");
        balances[msg.sender] -= _amount;
        assert(balances[msg.sender] >= 0);

        (bool success, ) = msg.sender.call{value: _amount}("");
        if (!success) {
            revert("Transfer failed");
        }
    }

    // Check balance function
    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // Owner can withdraw all funds
    function ownerWithdraw(uint256 _amount) public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(_amount <= address(this).balance, "Insufficient contract balance");
        
        (bool success, ) = owner.call{value: _amount}("");
        if (!success) {
            revert("Transfer failed");
        }
    }

    // Fallback function to receive ether
    fallback() external payable {}

    // Receive function to receive ether
    receive() external payable {}
}
