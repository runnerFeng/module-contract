pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/20 15:32
 * Desc:
 */
contract InfoFeed {
    function info() returns (uint ret){
        return msg.value;
    }
}


contract Consumer {
    function deposit() payable returns (uint){
        //为该合约存入一定量的ether
        return msg.value;
    }

    function left() constant returns (uint){
        return this.balance;
    }

    function callFeed(address addr) returns (uint) {
        //.value .gas 分别指定要发的ether的量和gas值
        //代码InfoFeed(addr)进行了一个显示的类型转换，声明了我们确定知道给定的地址是InfoFeed类型。所以这里并不会执行构造器的初始化。显示的类型强制转换，需要极度小心，不要尝试调用一个你不知道类型的合约。
        //.info.value(1).gas(8000)只是本地设置发送的数额和gas值，真正执行调用的是其后的括号
        return InfoFeed(addr).info().value(1).gas(8000)();
    }
}
