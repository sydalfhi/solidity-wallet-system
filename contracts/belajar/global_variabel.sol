// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GlobalVariables {
    /*
    =============================
    GLOBAL VARIABLES DI SOLIDITY
    =============================
    
    Solidity menyediakan banyak variabel global built-in yang bisa diakses 
    di dalam kontrak, tanpa harus dideklarasikan. 
    Mereka berguna untuk mendapatkan informasi tentang transaksi, blok, dan lingkungan eksekusi.
    
    Contoh Global Variables:
    1. msg.sender      => alamat pengirim transaksi/fungsi
    2. msg.value       => jumlah ETH yang dikirim bersama transaksi
    3. msg.data        => semua data input transaksi
    4. block.timestamp => waktu blok saat ini (unix timestamp)
    5. block.number    => nomor blok saat ini
    6. block.difficulty=> tingkat kesulitan blok saat ini
    7. tx.gasprice     => harga gas saat ini
    8. gasleft()       => gas tersisa untuk eksekusi kontrak
    9. address(this)   => alamat kontrak saat ini
    10. keccak256(...) => hashing data
    
    Kegunaan:
    - msg.sender & msg.value: untuk memvalidasi pengirim dan jumlah ETH
    - block.timestamp: untuk membuat fungsi yang tergantung waktu
    - tx.gasprice & gasleft(): untuk optimasi gas
    - address(this): untuk mengetahui saldo kontrak sendiri
    - keccak256: untuk membuat hash unik
    */

    // contoh penggunaan beberapa global variable
    address public pemilik;
    uint public saldoKontrak;

    constructor() {
        pemilik = msg.sender; // msg.sender = alamat pembuat kontrak
    }

    // Fungsi terima ETH
    function terimaETH() public payable {
        require(msg.value > 0, "Harus kirim ETH");
        saldoKontrak += msg.value; // update saldo
    }

    // Fungsi cek waktu blok
    function waktuSekarang() public view returns (uint) {
        return block.timestamp; // timestamp blok saat ini
    }

    // Fungsi cek nomor blok
    function nomorBlok() public view returns (uint) {
        return block.number; // nomor blok saat ini
    }

    // Fungsi hash data
    function hashData(string memory input) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(input)); // hash unik dari string
    }

    // Fungsi saldo kontrak
    function cekSaldo() public view returns (uint) {
        return address(this).balance; // saldo kontrak saat ini
    }
}
