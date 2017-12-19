pragma solidity ^0.4.0;


/**
 * @author jinx
 * @date 2017/12/19 10:35
 * Desc:
 */
contract MappingExample {
    mapping(address => uint) public balances;

    function update(uint amount)returns (address addr){
        balances[msg.sender] = amount;
        return msg.sender;
    }
}

contract MappingUser {
    address  conAddr;
    address  userAddr;

    function f()returns (uint amount) {
        conAddr = hex("0xf2bd5de8b57ebfc45dcee97524a7a08fccc80aef");
        userAddr = hex("0xca35b7d915458ef540ade6068dfe2f44e8fa733c");

        return MappingExample(conAddr).balances(userAddr);
    }
}
