pragma solidity ^0.4.0;


contract C {
    uint[] x;

    function f(uint[] memoryArray){
        x = memoryArray;
        var y = x;
        y[7];
        y.length = 2;
        delete x;
        g(x);
        h(x);
    }

    function g(uint[] storage x) internal {}

    function h(uint[] memoryArray){}
}
