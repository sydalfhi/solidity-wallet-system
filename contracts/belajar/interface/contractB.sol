// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "./IContractA.sol";

contract ContractB {
    IContractA public contractA;

    constructor(address _contractAAddress) {
        contractA = IContractA(_contractAAddress);
    }

    function bacaAngka() public view returns (uint) {
        return contractA.getAngka();
    }

}
