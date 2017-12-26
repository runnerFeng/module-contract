pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/26 10:23
 * Desc:可见性的标识符的定义位置，对于state variable是在类型后面，函数是在参数列表和返回关键字中间。
 */
contract C7 {

    function f(uint a) private returns (uint b){return a + 1;}

    function setData(uint a) internal {data = a;}

    uint public data;

}
