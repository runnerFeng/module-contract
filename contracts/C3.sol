pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/20 15:00
 * Desc:
 */
contract C3 {
    function g(uint a)returns (uint ret) {
        return f();
    }

    function f()returns (uint ret){
        return g(7) + f();
    }
}
