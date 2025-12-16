// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ContohStorage {
    //===== STORAGE VARIABLES =====
    // Semua tipe data wajib lokasi storage ditulis (string, bytes, array dinamis, struct)
    string public nama = "Syaid Alfarishi"; // public | storage
    uint public umur = 20; // public | storage
    bytes public dataBytes = "Hello"; // public | storage
    uint[] public dynamicArray; // public | storage

    struct Mahasiswa {
        string nama;
        uint umur;
    }
    Mahasiswa public mhs = Mahasiswa("Syaid", 20); // public | storage

    //===== SIMPLE VARIABLES (stack / memory) =====
    bool public status = true; // stack | storage
    address public pemilik; // stack | storage

    //===== EVENTS (log) =====
    event LogUpdateNama(string oldNama, string newNama);

    constructor() {
        pemilik = msg.sender;
    }

    //===== FUNCTION TYPES =====

    // Default: Bisa baca & tulis storage, bisa terima ETH (jika payable)
    function ubahNama(string memory _namaBaru) public {
        emit LogUpdateNama(nama, _namaBaru); // log
        nama = _namaBaru; // ubah storage
    }

    // view: bisa baca storage, tidak boleh ubah storage
    function lihatNama() public view returns (string memory) {
        return nama; // baca storage
    }

    // pure: tidak baca storage sama sekali
    function tambah(uint a, uint b) public pure returns (uint) {
        return a + b; // offline, tidak sentuh blockchain
    }

    // payable: bisa menerima ETH
    function terimaETH() public payable {
        // saldo kontrak bertambah otomatis
    }

    // external: hanya bisa dipanggil dari luar kontrak
    function externalFunction() external view returns (uint) {
        return umur;
    }

    // internal: hanya kontrak ini dan turunan yang bisa akses
    function internalFunction() internal view returns (string memory) {
        return nama;
    }

    // contoh memory & calldata
    function contohArray(uint[] memory angka) public pure returns (uint) {
        uint total = 0;
        for (uint i = 0; i < angka.length; i++) {
            total += angka[i];
        }
        return total;
    }

    //calldata lebih murah daripada memory
    function contohStringCalldata(
        string calldata input
    ) external pure returns (string calldata) {
        return input;
    }

    // menambah elemen ke dynamicArray
    function tambahArray(uint _angka) public {
        dynamicArray.push(_angka); // ubah storage
    }
}
