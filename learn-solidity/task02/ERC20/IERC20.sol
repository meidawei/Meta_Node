// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)
pragma solidity ^0.8.20;

/**
 * @dev ERC-20标准接口定义。
 */
interface IERC20 {
    /**
     * @dev 当`value`数量的代币从一个账户（`from`）移动到另一个账户（`to`）时触发。
     *
     * 注意`value`的值可以为零。
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev 当通过{approve}调用为`spender`设置了`owner`的代币使用额度（`value`）时触发。
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev 返回代币总供应量。
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev 返回`account`账户拥有的代币数量。
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev 将`value`数量的代币从调用者账户转移到`to`账户。
     *
     * 返回一个布尔值表示操作是否成功。
     *
     * 触发一个{Transfer}事件。
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev 返回`spender`将被允许代表`owner`通过{transferFrom}使用的剩余代币数量。默认情况下，这个值是零。
     *
     * 当{approve}或{transferFrom}被调用时，这个值会改变。
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev 将`value`数量的代币设置为`spender`通过调用者的代币的使用额度。
     *
     * 返回一个布尔值表示操作是否成功。
     *
     * 重要提示：改变使用额度的这个方法存在一个风险，即有人可能会通过不幸的交易顺序同时使用旧的和新的额度。
     * 一种可能的解决方案是首先将spender的额度降为0，然后再设置所需的值：https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * 触发一个{Approval}事件。
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev 使用许可机制从`from`向`to`移动`value`数量的代币。然后，`value`将从调用者的额度中扣除。
     *
     * 返回一个布尔值表示操作是否成功。
     *
     * 触发一个{Transfer}事件。
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}
