// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch {
    uint256[] public sortedArray;

    function setSortedArray(uint256[] memory _array) public {
        sortedArray = _array;
    }

    function binarySearch(uint256 target) public view returns (int256) {
        uint256 left = 0;
        uint256 right = sortedArray.length;
        
        // 处理空数组情况
        if (right == 0) {
            return -1;
        }
        
        right = right - 1;
        
        while (left <= right) {
            uint256 mid = left + (right - left) / 2;
            
            if (sortedArray[mid] == target) {
                return int256(mid);
            } else if (sortedArray[mid] < target) {
                left = mid + 1;
            } else {
                if (mid == 0) break;
                right = mid - 1;
            }
        }
        return -1;
    }
}