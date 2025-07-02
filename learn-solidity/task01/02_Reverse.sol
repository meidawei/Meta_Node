// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReverseString {
    // 存储需要操作的字符串（bytes类型）
    bytes public str;

    // 设置新字符串到状态变量
    function setString(bytes memory newStr) public {
        str = newStr;
    }

    function reverse() public {
        uint256 len = str.length;
        if (len < 2) return;
        uint256 left = 0;
        // 右指针
        uint256 right = len - 1;
        while (left < right) {
            bytes1 temp = str[left];
            str[left] = str[right];
            str[right] = temp;
            left++;
            right--;
        }
    }
}