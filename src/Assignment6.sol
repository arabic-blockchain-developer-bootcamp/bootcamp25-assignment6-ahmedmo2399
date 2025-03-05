// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Assignment6 {
    // 1. Declare the `FundsDeposited` event
    event FundsDeposited(address indexed sender, uint amount);

    // 2. Declare the `FundsWithdrawn` event
    event FundsWithdrawn(address indexed receiver, uint amount);

    // 3. Mapping to track user balances
    mapping(address => uint) public balances;

    // Modifier to check if sender has enough balance
    modifier hasEnoughBalance(uint amount) {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        _;
    }

    // Function to deposit Ether
    function deposit() external payable {
        require(msg.value > 0, "Must deposit some Ether");
        balances[msg.sender] += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    // Function to withdraw Ether
    function withdraw(uint amount) external hasEnoughBalance(amount) {
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit FundsWithdrawn(msg.sender, amount);
    }

    // Function to check the contract balance
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
