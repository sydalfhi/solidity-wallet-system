// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContractA {
    uint public angka = 10;

    function getAngka() public view returns (uint) {
        return angka;
    }

    function setAngka(uint _angka) public {
        angka = _angka;
    }
}
