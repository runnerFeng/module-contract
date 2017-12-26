pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/26 10:56
 * Desc:访问函数有外部(external)可见性。如果通过内部(internal)的方式访问，比如直接访问，你可以直接把它当一个变量进行使用，但如果使用外部(external)的方式来访问，如通过this.，那么它必须通过函数的方式来调用。
 */
contract C10 {
    uint public c = 10;

    function accessInternal()returns (uint){
        return c;
    }

    function accessExternal()returns (uint){
        return this.c();
    }
}
