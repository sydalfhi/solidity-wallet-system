// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hewan {
    string public nama;

    constructor(string memory _nama) {
        nama = _nama;
    }

    function suara() public pure virtual returns (string memory) {
        return "Hewan bersuara";
    }
}

contract Mamalia {
    uint public jumlahKaki;

    constructor(uint _jumlahKaki) {
        jumlahKaki = _jumlahKaki;
    }
}


contract Kucing is Hewan, Mamalia {
    string public warnaBulu;

    constructor(
        string memory _nama,
        uint _jumlahKaki,
        string memory _warnaBulu
    )
        Hewan(_nama)          // manggil variable
        Mamalia(_jumlahKaki)  // manggil variabel
    {
        warnaBulu = _warnaBulu;
    }

    function suara() public pure override returns (string memory) {
        return "Meong";
    }
}
/* | Kasus                   | Solusi                    |
| ----------------------- | ------------------------- |
| Parent tanpa parameter  | Otomatis dipanggil        |
| Parent dengan parameter | Anak **WAJIB kirim**      |
| Multiple parent         | Panggil semua constructor |
| Urutan eksekusi         | Sesuai urutan `is`        |
| Constructor override    | ❌ Tidak bisa              |
 */