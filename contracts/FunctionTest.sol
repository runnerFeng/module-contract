pragma solidity ^0.4.0;


contract FunctionTest {
    function internalFun() internal {}

    function externalFun() external {}

    function callFun(){
        //call a internal function directly
        internalFun;
        //use keyword 'this' to call a external function,in this regard opposite to the other language
        this.externalFun;
    }

}


contract FunctionTest1 {

    function externalCall(FunctionTest functionTest){
        //call other contract`s external function,but can`t call other contract`s internal function
        functionTest.externalFun;
    }
}
