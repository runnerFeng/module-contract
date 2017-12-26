pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/26 15:46
 * Desc:
 */

contract C11 {
    //不是所有的类型都支持常量，当前支持的仅有值类型和字符串。
    uint constant x = 32 ** 22 + 8;
    string constant text = "abc";
    bytes32 constant myhash = keccak256("abc");
}

contract C2 {
    function f(uint a, uint b) constant returns (uint){
        return a * (b + 42);
    }
}