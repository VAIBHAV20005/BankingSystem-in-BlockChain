// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

contract BakingSystem{
 
    event DepositSucesssful(string message);
    event withdrawSucessful(string message);
    

    function Deposit ( ) external payable {
       
      emit DepositSucesssful("Deposit Sucessfully....");
    }
    function Withdraw (uint256 _amount) external  payable  {
        _amount = _amount * 1 ether;
        payable (msg.sender).transfer(_amount);
        emit withdrawSucessful("withdrawal Sucessfully....");
       
    }
}