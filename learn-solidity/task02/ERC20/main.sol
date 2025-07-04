// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "IERC20.sol";
import "IERC20Metadata.sol";

contract Name is IERC20, IERC20Metadata {
    uint256 total;

    mapping(address => uint256) values;

    mapping(address => mapping(address => uint256)) sqs;

    constructor(uint256 _total) {
        total = _total;
        values[msg.sender] = total;
    }

    /**
     * @dev 返回代币的名称。
     * 此函数用于获取代币的全称。它是公共的和只读的，意味着它不会改变任何状态变量并且调用它是免费的
     */
    function name() external pure returns (string memory) {
        return "LEARN-solidity";
    }

    /**
     * @dev 返回代币的符号。
     * 此函数用于获取代币的简称或符号。这通常是代币名称的缩写，也是公共的和只读的。
     */
    function symbol() external pure returns (string memory) {
        return "LEARN";
    }

    /**
     * @dev 返回代币的小数位数。3 / 1000
     * 函数用于获取代币的小数位数。这告诉你代币可以被分割到什么程度。例如，如果小数位为3，则代币可以分割到0.001
     */
    function decimals() external pure returns (uint8) {
        return 0;
    }

    /**
     * @dev 返回代币总供应量。
     */
    function totalSupply() external view returns (uint256) {
        return total;
    }

    /**
     * @dev 返回`account`账户拥有的代币数量。
     */
    function balanceOf(address account) external view returns (uint256) {
        return values[account];
    }

    /**
     * @dev 将`value`数量的代币从调用者账户转移到`to`账户。
     *
     * 返回一个布尔值表示操作是否成功。
     *
     * 触发一个{Transfer}事件。
     */
    function transfer(address to, uint256 value) external returns (bool) {
        require(values[msg.sender] >= value, "yu e bu zu");
        values[msg.sender] = values[msg.sender] - value;
        values[to] = values[to] + value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    /**
     * @dev 返回`spender`将被允许代表`owner`通过{transferFrom}使用的剩余代币数量。默认情况下，这个值是零。
     *
     * 当{approve}或{transferFrom}被调用时，这个值会改变。
     */
    function allowance(address owner, address spender) external view returns (uint256) {
        return sqs[owner][spender];
    }

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
    function approve(address spender, uint256 value) external returns (bool) {
        require(values[msg.sender] >= value, "yu e bu zu");
        sqs[msg.sender][spender] = sqs[msg.sender][spender] + value;

        emit Approval(msg.sender, spender, value);
        return true;
    }

    /**
     * @dev 使用许可机制从`from`向`to`移动`value`数量的代币。然后，`value`将从调用者的额度中扣除。
     *
     * 返回一个布尔值表示操作是否成功。
     *
     * 触发一个{Transfer}事件。
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        require(sqs[from][msg.sender] >= value, unicode"余额不足");
        require(values[from] >= value, unicode"余额不足");
        values[from] = values[from] - value;
        values[to] = values[to] + value;
        sqs[from][msg.sender] = sqs[from][msg.sender] - value;
        emit Transfer(from, to, value);
        return true;
    }
}
