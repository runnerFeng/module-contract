pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/26 10:50
 * Desc:
 */
contract C9 {
    uint public c = 10;
}

contract D {
    C c = new C();

    function getDataUsingAccessor()returns (uint){
        //此处c()为访问函数
        uint local = c.c();
    }
}
