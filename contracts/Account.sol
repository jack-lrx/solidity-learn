// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Account {
    uint256 public balance;

    function deposit(uint256 _amount) public {
        uint256 oldBalance = balance;
        uint256 newBalance = balance + _amount;
        require(newBalance > oldBalance, "Overflow");

        balance = newBalance;
        assert(balance >= oldBalance);
    }

    function withdraw(uint256 _amount) public {
        uint256 oldBalance = balance;
        // require(oldBalance >= _amount, "Underflow");
        if(balance < _amount) {
            revert("Underflow");
        }

        balance -= _amount;
        assert(balance <= oldBalance);
    }
}