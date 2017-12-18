pragma solidity ^0.4.0;


contract C2 {
    //storage
    uint[] u;

    bytes b;

    //push test
    function testArrayPush() returns (uint){
        uint[3] memory a = [uint(1), 2, 3];
        u = a;
        return u.push(4);

        //memory和storage的变长数组不能互相赋值
        //uint[3] z = a;
    }

    function testBytesPush() returns (uint){
        b = new bytes(3);
        return b.push(4);
    }
}
