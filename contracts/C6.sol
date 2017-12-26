pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/21 10:08
 * Desc:
 */
contract C6 {
    function foo()returns (uint){
        uint bar = 5;
        // baz is implicitly initialized as 0
        if (true) {
            bar = baz + bar;
        } else {
            uint baz = 10;
        }
        //return 5
        return bar;
    }
}
