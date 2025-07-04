// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)
pragma solidity ^0.8.20;

/**
 * @dev ERC-20标准中可选的元数据函数的接口。
 */
interface IERC20Metadata {
    /**
     * @dev 返回代币的名称。
     * 此函数用于获取代币的全称。它是公共的和只读的，意味着它不会改变任何状态变量并且调用它是免费的
     */
    function name() external view returns (string memory);

    /**
     * @dev 返回代币的符号。
     * 此函数用于获取代币的简称或符号。这通常是代币名称的缩写，也是公共的和只读的。
     */
    function symbol() external view returns (string memory);

    /**
     * @dev 返回代币的小数位数。
     * 函数用于获取代币的小数位数。这告诉你代币可以被分割到什么程度。例如，如果小数位为3，则代币可以分割到0.001
     */
    function decimals() external view returns (uint8);
}
