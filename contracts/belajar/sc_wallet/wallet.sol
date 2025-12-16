// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleWallet {
    address private owner;
    constructor() {
        owner = msg.sender;
    }

    // address => jumlah saldo (dalam wei)
    mapping(address => uint) public balances;

    event Deposit(address indexed user, uint amount);
    event Transfer(address indexed from, address indexed to, uint amount);
    event Withdraw(address indexed user, uint amount);

    // =====================
    // INTERNAL FUNCTION
    // =====================

    // Fungsi internal untuk menyimpan saldo ke contract
    // Dipanggil oleh deposit(), receive(), dan fallback()
    function _deposit() private {
        // Pastikan ETH yang dikirim lebih dari 0
        require(msg.value > 0, "Deposit tidak boleh 0");

        // Tambahkan saldo ke address pengirim
        balances[msg.sender] += msg.value;

        // Emit event Deposit
        emit Deposit(msg.sender, msg.value);
    }

    // =====================
    // EXTERNAL FUNCTION
    // =====================

    // Fungsi deposit manual
    // Owner dapat menyetor ETH ke contract
    function deposit() external payable {
        _deposit();
    }

    // Fungsi receive dijalankan ketika contract menerima ETH
    // tanpa data (contoh: transfer biasa)
    receive() external payable {
        _deposit();
    }

    // Fungsi fallback dijalankan ketika contract menerima ETH
    // dengan data atau fungsi tidak ditemukan
    fallback() external payable {
        _deposit();
    }

    // =====================
    // VIEW FUNCTION
    // =====================

    // Melihat saldo address tertentu
    function getBalance(address user) external view returns (uint) {
        return balances[user];
    }

    // =====================
    // TRANSFER FUNCTION
    // =====================

    // Memindahkan saldo internal ke address lain
    function transfer(address to, uint amount) external {
        require(balances[msg.sender] >= amount, "Saldo tidak cukup");
        require(to != address(0), "Address tidak valid");

        balances[msg.sender] -= amount;
        balances[to] += amount;

        emit Transfer(msg.sender, to, amount);
    }

    // =====================
    // WITHDRAW (BELUM DIBUAT)
    // =====================
    function withdraw(uint amount) external {
        require(balances[msg.sender] >= amount, "Saldo tidak cukup");

        balances[msg.sender] -= amount;

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdraw gagal");

        emit Withdraw(msg.sender, amount);
    }

    /*
FLOW PENGGUNAAN WALLET (CONTOH):

1. CB2 deposit 2 ETH ke contract
   - ETH CB2        : -2 ETH
   - ETH Contract   : +2 ETH
   - Internal CB2   : 2 ETH

2. CB2 cek saldo internal
   balances[CB2] = 2 ETH

3. CB2 transfer internal 1 ETH ke C4
   - Internal CB2   : 1 ETH
   - Internal C4    : 1 ETH
   - ETH Contract   : TETAP (2 ETH)
   - ETH Wallet C4  : TIDAK BERUBAH

4. C4 withdraw 1 ETH
   - Internal C4    : 0 ETH
   - ETH Contract   : -1 ETH
   - ETH Wallet C4  : +1 ETH

5. CB2 transfer internal 1 ETH lagi ke C4
   - Internal CB2   : 0 ETH
   - Internal C4    : 1 ETH

6. C4 withdraw 1 ETH lagi
   - Internal C4    : 0 ETH
   - ETH Wallet C4  : +1 ETH (total +2 ETH)
*/
}
