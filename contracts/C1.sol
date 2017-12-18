pragma solidity ^0.4.0;


contract C1 {
    //memory array
    function f(){
        //create an memory array
        uint[] memory a = new uint[](7);
        //can`t modify the memory array length
        //a.length = 100;
    }

    //storage array
    uint[] b;

    function g(){
        b = new uint[](7);
        b.length = 10;
        b[9] = 100;
    }
}
