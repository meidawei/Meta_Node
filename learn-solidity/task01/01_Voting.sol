// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // 固定三位候选人
    string[3] names = [unicode"一号候选人", unicode"二号候选人", unicode"三号候选人"];
    // 候选人得票数
    uint256[3] votes = [0, 0, 0];
    // 记录已投票地址
    mapping(address => bool) hasVoted;

    // 投票函数
    function vote(uint256 _index) public {
        // 验证候选人ID有效性
        require(_index < names.length, unicode"候选人不存在");
        // 检查是否已投票
        require(!hasVoted[msg.sender], unicode"您已经投过票了");
        // 增加候选人票数
        votes[_index] += 1;
        // 标记地址为已投票
        hasVoted[msg.sender] = true;
    }

    // 获取候选人票数
    function getVotes(uint256 _index) public view returns (string memory, uint256) {
        require(_index < names.length, unicode"候选人不存在");
        return (names[_index], votes[_index]);
    }

    // 重置所有票数
    function resetVotes() public {
        for (uint i = 0; i < votes.length; i++) {
            votes[i] = 0;
        }
    }
}