pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/26 10:28
 * Desc:
 */
contract C8 {
    uint private data;

    function f(uint a) private returns (uint){return a + 1;}

    function setData(uint a){data = a;}

    function getData() public returns (uint){return data;}

    function compute(uint a, uint b) internal returns (uint){return a + b;}
}

contract D {
    function readData(){
        C c = new C();
        //error，f是私有函数，只能在合约内部调用
        //uint local = c.f(2);
        c.setData(2);
        local = c.getData();
        //error,compute是internal函数，只能内部调用或者子类调用
        //local = c.compute(1,2);
    }
}

contract E is C {
    function g(){
        C c = new C();
        //子类访问父类internal函数
        uint val = c.computer(1, 2);
    }
}