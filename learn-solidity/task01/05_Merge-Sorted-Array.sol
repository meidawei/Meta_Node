// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeSortedArray {
    // 存储第一个有序数组（有足够空间容纳两个数组）
    uint256[] public nums1;
    function setNums1(uint256[] memory _nums1) public {
        nums1 = _nums1;
    }
    function merge(uint256[] memory _nums2, uint256 m, uint256 n) public {
        require(nums1.length >= m + n, "nums1 has insufficient space");
        // nums1有效元素末尾
        int p1 = int(m) - 1;   
        // nums2末尾 
        int p2 = int(n) - 1;   
        // 合并后数组末尾 
        int p = int(m + n) - 1; 
        // 从后向前合并两个数组
        while (p2 >= 0) {
            // 当nums1还有元素且当前元素大于nums2当前元素
            if (p1 >= 0 && nums1[uint(p1)] > _nums2[uint(p2)]) {
                nums1[uint(p)] = nums1[uint(p1)];
                p1--;
            } 
            // 否则使用nums2的当前元素
            else {
                nums1[uint(p)] = _nums2[uint(p2)];
                p2--;
            }
            p--;
        }
    }

    function setAndMerge(
        uint256[] memory _nums1,
        uint256 m,
        uint256[] memory _nums2,
        uint256 n
    ) public {
        setNums1(_nums1);
        merge(_nums2, m, n);
    }
}