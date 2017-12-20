pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/20 11:19
 * Desc:
 */
contract DeleteExample {
    uint data;
    uint[] dataArray;

    function f(){
        //值传递
        uint x = data;
        //删除x不会影响data
        delete x;
        //删除data不会影响X
        delete data;
        //引用传递
        uint[] y = dataArray;
        //删除dataArray会影响y，y也将被赋值为初值
        delete dataArray;
        //下面的操作为报错，因为删除是一个赋值操作，不能向引用类型的storage直接赋值从而报错
        //delete y;
    }

    //获得当前时间
    function nowInSeconds()returns (uint256){
        return now;
    }

    function f(uint start, uint daysAfter){
        if (now > start + daysAfter * 1days) {

        }
    }

}
