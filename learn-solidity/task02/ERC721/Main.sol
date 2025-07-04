// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "IERC721.sol";
import "IERC721Metadata.sol";
import "IERC165.sol";

contract Name is IERC721, IERC721Metadata, IERC165 {
    uint256 index;

    // token 管理员信息
    mapping(uint256 => address) admins;

    // token 二级管理员信息
    mapping(uint256 => address) sqs;

    // token 索引信息
    mapping(uint256 => uint256) indexs;

    // token  资源url 信息
    mapping(uint256 => string) urls;

    // 记录用户有多少nft 数量
    mapping(address => uint256) values;

    // 账号级别授权
    mapping(address => mapping (address => bool)) allSqs;

    /**
     * @dev 返回代币集合的名称。
     */
    function name() external pure returns (string memory) {
        return "STUDY";
    }

    /**
     * @dev 返回代币集合的符号。
     */
    function symbol() external pure returns (string memory) {
        return "STUDY";
    }

    function createToken(string memory url) public {
        index = index + 1;
        uint256 tokenId = index;
        admins[tokenId] = msg.sender;
        indexs[tokenId] = tokenId;
        urls[tokenId] = url;
        values[msg.sender] = values[msg.sender] + 1;
    }

    /**
     * @dev 返回`tokenId`代币的统一资源标识符（URI）。
     */
    function tokenURI(uint256 tokenId) external view returns (string memory) {
        return urls[tokenId];
    }

    /**
     * @dev 返回`owner`账户中的代币数量。
     */
    function balanceOf(address owner) external view returns (uint256 balance) {
        return values[owner];
    }

    /**
     * @dev 返回`tokenId`代币的拥有者。
     *
     * 要求：
     *
     * - `tokenId`必须存在。
     */
    function ownerOf(uint256 tokenId) public view returns (address owner) {
        return admins[tokenId];
    }

    function _checkToken(uint256 tokenId) internal view {
        require(indexs[tokenId] != 0, "nft bcz");
    }

    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal {
        require(address(0) != from, "dz b cz");
        require(address(0) != to, "dz b cz");
        _checkToken(tokenId);
        require(ownerOf(tokenId) == from, " nft bcz");

        //它必须已经通过{approve}或{setApprovalForAll}被授权移动此代币。
        if (msg.sender != from) {
            //approve
            if (sqs[tokenId] != msg.sender) {
                //setApprovalForAll
                if (allSqs[from][msg.sender] == false) {
                    revert(" my sq");
                }
            }else {
                sqs[tokenId] = address(0);
            }
        }
        admins[tokenId] = to;
        values[from] = values[from] - 1;
        values[to] = values[to] + 1;
        emit Transfer(from, to, tokenId);
    }

    /**
     * @dev 安全地将`tokenId`代币从`from`转移到`to`。
     *
     * 要求：
     *
     * - `from`不能是零地址。
     * - `to`不能是零地址。
     * - `tokenId`代币必须存在且由`from`拥有。
     * - 如果调用者不是`from`，它必须已经通过{approve}或{setApprovalForAll}被授权移动此代币。
     * - 如果`to`指向一个智能合约，它必须实现{IERC721Receiver-onERC721Received}，在安全转移时调用。
     *
     * 触发一个{Transfer}事件。
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external {
        _transfer(from, to, tokenId);
    }

    /**
     * @dev 安全地将`tokenId`代币从`from`转移到`to`，首先检查合约接收者是否了解ERC-721协议，以防止代币被永久锁定。
     *
     * 要求：
     *
     * - `from`不能是零地址。
     * - `to`不能是零地址。
     * - `tokenId`代币必须存在且由`from`拥有。
     * - 如果调用者不是`from`，它必须已经通过{approve}或{setApprovalForAll}被授权移动此代币。
     * - 如果`to`指向一个智能合约，它必须实现{IERC721Receiver-onERC721Received}，在安全转移时调用。
     *
     * 触发一个{Transfer}事件。
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external {
        _transfer(from, to, tokenId);
    }

    /**
     * @dev 将`tokenId`代币从`from`转移到`to`。
     *
     * 警告：注意调用者负责确认接收者能够接收ERC-721代币，否则它们可能会被永久丢失。使用{safeTransferFrom}可以防止丢失，尽管调用者必须理解这会增加一个外部调用，可能会创建重入漏洞。
     *
     * 要求：
     *
     * - `from`不能是零地址。
     * - `to`不能是零地址。
     * - `tokenId`代币必须由`from`拥有。
     * - 如果调用者不是`from`，它必须已经通过{approve}或{setApprovalForAll}被授权移动此代币。
     *
     * 触发一个{Transfer}事件。
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external {
        _transfer(from, to, tokenId);
    }

    /**
     * @dev 授权`to`转移`tokenId`代币到另一个账户。当代币转移时，授权将被清除。
     *
     * 一次只能授权一个账户，所以授权给零地址将清除之前的授权。
     *
     * 要求：
     *
     * - 调用者必须是代币的拥有者或被批准的操作员。
     * - `tokenId`必须存在。
     *
     * 触发一个{Approval}事件。
     */
    function approve(address to, uint256 tokenId) external {
        _checkToken(tokenId);
        require(admins[tokenId] == msg.sender, "nft bcz");
        sqs[tokenId] = to;
        emit Approval(msg.sender, to, tokenId);
    }

    /**
     * @dev 将`operator`作为调用者的操作员进行批准或移除。
     * 操作员可以调用{transferFrom}或{safeTransferFrom}来操作调用者拥有的任何代币。
     *
     * 要求：
     *
     * - `operator`不能是零地址。
     *
     * 触发一个{ApprovalForAll}事件。
     */
    function setApprovalForAll(address operator, bool approved) external {
        require(address(0) != operator, "dz b cz");
        allSqs[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    /**
     * @dev 返回被批准管理`tokenId`代币的账户。
     *
     * 要求：
     *
     * - `tokenId`必须存在。
     */
    function getApproved(uint256 tokenId) external view returns (address operator) {
        _checkToken(tokenId);
        return sqs[tokenId];
    }

    /**
     * @dev 返回`operator`是否被允许管理`owner`的所有资产。
     *
     * 见{setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool) {
        return  allSqs[owner][operator];
    }



    /**
     * @dev 如果此合约实现了由 `interfaceId` 定义的接口，则返回 true。有关如何创建这些 ID 的更多信息，请参见相应的
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[ERC 部分]。
     *
     * 此函数调用必须消耗少于 30,000 gas。
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return true;
    }
}
