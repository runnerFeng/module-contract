pragma solidity ^0.4.0;


contract SimpleStorage {
    uint valueStore;// state variable

    function add(uint x, uint y)returns (uint z){
        z = x + y;
    }

    function divide()returns (uint z){
        //z = 0
        uint x = 1;
        uint y = 2;
        z = x / y;
    }
}
