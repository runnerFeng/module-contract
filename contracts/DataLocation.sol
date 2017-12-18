pragma solidity ^0.4.0;


contract DataLocation {
    uint valueType;

    mapping (uint => uint) public referenceType;

    function changeMemory(){
        var tmp = valueType;
        tmp = 100;
    }

    function changeStorage(){
        var tmp = referenceType;
        tmp[1] = 100;
    }

    function getAll()returns (uint, uint){
        return (valueType, referenceType[1]);
    }
}
