// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Assignment6} from "../src/Assignment6.sol";

contract Assignment6Test is Test {
    Assignment6 assignment;

    event FundsDeposited(address indexed sender, uint amount);
    event FundsWithdrawn(address indexed receiver, uint amount);

    function setUp() public {
        assignment = new Assignment6();
    }

    function testDeposit() public {
        vm.deal(address(this), 1 ether); // تزويد الحساب بـ 1 ETH
        vm.expectEmit(true, true, false, true);
        emit FundsDeposited(address(this), 1 ether); // مطابقة الحدث
        assignment.deposit{value: 1 ether}();
        uint balance = assignment.balances(address(this));
        assertEq(balance, 1 ether, "Balance should be 1 ether");
    }

    function testWithdraw() public {
        vm.deal(address(this), 1 ether);
        assignment.deposit{value: 1 ether}();
        vm.expectEmit(true, true, false, true);
        emit FundsWithdrawn(address(this), 0.5 ether);
        assignment.withdraw(0.5 ether);
        uint balance = assignment.balances(address(this));
        assertEq(balance, 0.5 ether, "Balance should be 0.5 ether");
    }

    function testContractBalance() public {
        vm.deal(address(this), 1 ether);
        assignment.deposit{value: 1 ether}();
        uint contractBalance = assignment.getContractBalance();
        assertEq(contractBalance, 1 ether, "Contract balance should be 1 ether");
    }

    receive() external payable {}
}
