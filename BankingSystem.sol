// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

contract LaxmiChitFund 
{
    struct Account 
    {
        address owner;
        uint256 Balance;
        uint256 IssueDateTime;
    }

    mapping (address => Account) public accounts;

    event balanceAdded(address owner, uint256 amount, uint256 TimeStamp);
    event WithdrewalDone(address owner, uint256 amount, uint256 TimeStamp, string message);

    modifier Minmum()
    {
        require(msg.value >= 1 ether, "Please! Add Sufficient Balance");
        _;
    }

    // Account Creation
    function AccountCreation() public payable Minmum
    {
        accounts[msg.sender].owner = msg.sender;
        accounts[msg.sender].Balance = msg.value;
        accounts[msg.sender].IssueDateTime = block.timestamp;

        emit balanceAdded(msg.sender, msg.value, block.timestamp);
    }

    // Depositing Funds
    function Deposit() public payable Minmum
    {
        accounts[msg.sender].Balance += msg.value;
        emit balanceAdded(msg.sender, msg.value, block.timestamp);
    }

    // Withdrawing Funds
    function Withdrew() public payable 
    {
        uint256 balance = accounts[msg.sender].Balance;
        require(balance > 0, "Insufficient balance");
        accounts[msg.sender].Balance = 0; // Prevent reentrancy attacks
        payable(msg.sender).transfer(balance);
        emit WithdrewalDone(msg.sender, balance, block.timestamp, "Withdrewal Done");
    }
}
