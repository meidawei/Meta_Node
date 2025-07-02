// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntegerToRoman {
    function intToRoman(uint256 num) public pure returns (string memory) {
        require(num >= 1 && num <= 3999, "Number out of range (1-3999)");
        bytes memory result = new bytes(0);
        uint256[13] memory values = [uint256(1000), 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        bytes[13] memory symbols = [bytes("M"), bytes("CM"), bytes("D"), bytes("CD"), bytes("C"), bytes("XC"), bytes("L"), bytes("XL"), bytes("X"), bytes("IX"), bytes("V"), bytes("IV"), bytes("I")];
        for (uint256 i = 0; i < 13; i++) {
            while (num >= values[i]) {
                result = bytes.concat(result, symbols[i]);
                num -= values[i];
            }
            if (num == 0) break;
        }
        return string(result);
    }
}