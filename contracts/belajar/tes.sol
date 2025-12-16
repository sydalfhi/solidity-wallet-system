// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleWallet {

    // Mapping
    mapping(address => uint) public saldo;

    // Event
    event Deposit(address user, uint amount);
    event Withdraw(address user, uint amount);

    // Menyimpan saldo
    function deposit() public payable {
        saldo[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Mengambil saldo
    function withdraw(uint _amount) public {
        require(saldo[msg.sender] >= _amount, "Saldo tidak cukup");
        saldo[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);

        emit Withdraw(msg.sender, _amount);
    }
}

