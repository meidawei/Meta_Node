// SPDX-License-Identifier: MIT
// OpenZeppelin 合约（最新版本 v5.0.0）（utils/introspection/IERC165.sol）
pragma solidity ^0.8.20;

/**
 * @dev ERC-165 标准的接口，定义在
 * https://eips.ethereum.org/EIPS/eip-165[ERC] 中。
 *
 * 实现者可以声明对合约接口的支持，其他人可以查询这些接口是否被支持（{ERC165Checker}）。
 *
 * 实现请参见 {ERC165}。
 */
interface IERC165 {
    /**
     * @dev 如果此合约实现了由 `interfaceId` 定义的接口，则返回 true。有关如何创建这些 ID 的更多信息，请参见相应的
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[ERC 部分]。
     *
     * 此函数调用必须消耗少于 30,000 gas。
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}
