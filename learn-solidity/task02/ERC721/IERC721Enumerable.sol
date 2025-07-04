// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC721/extensions/IERC721Enumerable.sol)

pragma solidity ^0.8.20;

/**
 * @title ERC-721非同质化代币标准，可选的枚举扩展
 * @dev 见 https://eips.ethereum.org/EIPS/eip-721
 */
interface IERC721Enumerable  {
    /**
     * @dev 返回合约中存储的代币总量。
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev 返回`owner`拥有的代币列表中给定`index`处的代币ID。
     * 与{balanceOf}一起使用，可以枚举``owner``的所有代币。
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);

    /**
     * @dev 返回合约中存储的所有代币列表中给定`index`处的代币ID。
     * 与{totalSupply}一起使用，可以枚举所有代币。
     */
    function tokenByIndex(uint256 index) external view returns (uint256);
}
