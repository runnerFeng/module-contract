pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/26 16:07
 * Desc:每一个合约有且仅有一个没有名字的函数。这个函数无参数，也无返回值。如果调用合约时，没有匹配上任何一个函数(或者没有传哪怕一点数据)，就会调用默认的回退函数。
 *      此外，当合约收到ether时（没有任何其它数据）
 */

contract C13 {
    // This function is called for all messages sent to
    // this contract (there is no other function).
    // Sending Ether to this contract will cause an exception,
    // because the fallback function does not have the "payable"
    // modifier.
    function(){
        x = 1;
    }

    uint x;
}

// This contract keeps all Ether sent to it with no way
// to get it back.
contract Sink {
    function() payable {}
}

contract Caller {
    function callTest(Test test) {
        test.call(0xabcdef01);
        // hash does not exist
        // results in test.x becoming == 1.

        // The following call will fail, reject the
        // Ether and return false:
        test.send(2 ether);
    }
}
