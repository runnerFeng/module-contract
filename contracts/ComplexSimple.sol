pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/26 11:52
 * Desc:
 */
contract ComplexSimple {
    struct Cat {
        uint a;
        bytes b;
        mapping(uint => uint) map;
    }

    mapping(uint => mapping(bool => Cat))public content;

    function initial(){
        content[0][true] = Cat(1, 1);
        content[0][true].map[0] = 10;
    }

    function get()returns (uint, bytes, uint){
        return (content[0][true].a, content[0][true].b, content[0][true].map[0]);
    }
}

contract Complex {
    struct Data {
        uint a;
        bytes b;
        mapping(uint => uint) map;
    }

    mapping(uint => mapping(bool => Data[]))public data;
}
