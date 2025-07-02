// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanToInteger {
    function romanToInt(string memory s) public pure returns (uint256) {
        // 将字符串转换为字节数组以便逐个字符处理
        bytes memory roman = bytes(s);
        uint256 length = roman.length;
        if (length == 0) {
            return 0;
        }
        uint256 result = 0;
        uint256 prevValue = 0;
        for (uint256 i = length; i > 0; i--) {
            uint256 currentValue = _charToValue(roman[i - 1]);
            if (currentValue < prevValue) {
                result -= currentValue;
            } else {
                result += currentValue;
            }
            prevValue = currentValue;
        }
        return result;
    }
    
    function _charToValue(bytes1 c) private pure returns (uint256) {
        // 使用 switch 语句高效匹配字符
        if (c == "I") return 1;
        else if (c == "V") return 5;
        else if (c == "X") return 10;
        else if (c == "L") return 50;
        else if (c == "C") return 100;
        else if (c == "D") return 500;
        else if (c == "M") return 1000;
        else revert("Invalid Roman character");
    }
}