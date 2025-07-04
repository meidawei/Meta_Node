// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OptimizedBeggingContract {
    // 公开合约所有者
    address public owner; 
    // 公开捐赠映射
    mapping(address => uint256) public donations; 
    // 捐赠总额
    uint256 public totalDonations; 
    // 捐赠时间控制
    uint256 public donationStartTime;
    uint256 public donationEndTime;
    bool public donationTimeEnabled;
    
    // 排行榜
    struct TopDonor {
        address donor;
        uint256 amount;
    }
    // 公开前三名
    TopDonor[3] public topDonors; 
    
    // 事件
    event DonationReceived(address indexed donor, uint256 amount);
    event FundsWithdrawn(address indexed owner, uint256 amount);
    event DonationTimeUpdated(uint256 start, uint256 end);
    event TopDonorUpdated(uint256 position, address donor, uint256 amount);

    constructor() {
        owner = msg.sender;
        donationTimeEnabled = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier withinDonationPeriod() {
        if (donationTimeEnabled) {
            require(
                block.timestamp >= donationStartTime && 
                block.timestamp <= donationEndTime,
                "Donations only accepted during specified period"
            );
        }
        _;
    }

    // 捐赠函数
    function donate() external payable withinDonationPeriod {
        require(msg.value > 0, "Donation must be greater than 0");
        donations[msg.sender] += msg.value;
        totalDonations += msg.value;
        _updateTopDonors(msg.sender, donations[msg.sender]);
        emit DonationReceived(msg.sender, msg.value);
    }

    // 提取资金
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");
        
        payable(owner).transfer(balance);
        emit FundsWithdrawn(owner, balance);
    }

    // 设置捐赠时间
    function setDonationTime(uint256 start, uint256 end) external onlyOwner {
        require(start < end, "Start time must be before end time");
        donationStartTime = start;
        donationEndTime = end;
        donationTimeEnabled = true;
        emit DonationTimeUpdated(start, end);
    }

    // 启用/禁用时间限制
    function toggleDonationTime(bool enable) external onlyOwner {
        donationTimeEnabled = enable;
    }

    // 更新排行榜
    function _updateTopDonors(address donor, uint256 amount) private {
        // 检查是否已在榜中
        int256 currentIndex = -1;
        for (uint256 i = 0; i < topDonors.length; i++) {
            if (topDonors[i].donor == donor) {
                currentIndex = int256(i);
                break;
            }
        }
        // 如果已在榜中，更新金额
        if (currentIndex >= 0) {
            topDonors[uint256(currentIndex)].amount = amount;
        } 
        // 如果不在榜中且金额超过最后一名
        else if (amount > topDonors[2].amount) {
            // 替换最后一名
            topDonors[2] = TopDonor(donor, amount);
            currentIndex = 2;
        } else {
            return;
        }
        
        // 排序排行榜（冒泡排序适用于小数组）
        for (uint256 i = uint256(currentIndex); i > 0; i--) {
            if (topDonors[i].amount > topDonors[i-1].amount) {
                // 交换位置
                TopDonor memory temp = topDonors[i-1];
                topDonors[i-1] = topDonors[i];
                topDonors[i] = temp;
                emit TopDonorUpdated(i-1, topDonors[i-1].donor, topDonors[i-1].amount);
            } else {
                break;
            }
        }
    }

    // 获取前三名地址
    function getTopDonors() public view returns (TopDonor[3] memory) {
        return topDonors;
    }
    
    // 获取合约余额
    function contractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}