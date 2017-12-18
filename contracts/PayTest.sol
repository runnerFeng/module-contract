pragma solidity ^0.4.0;


contract PayTest {
    function getBalance()returns (uint){
        this.balance;
    }

    function deposit() payable returns (address addr, uint amount, bool success){
        return (msg.sender, msg.value, this.send(msg.value));
    }
}
