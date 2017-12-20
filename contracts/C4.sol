pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/20 16:03
 * Desc:
 */
contract C4 {
    function add(uint val1, uint val2)returns (uint){
        return val1 + val2;
    }

    function g()returns (uint){
        //这种按变量名传参时可以不管顺序，但是要保证类型和数量要和定义的一致
        return add({val2 : 2, val1 : 1});
    }
}
