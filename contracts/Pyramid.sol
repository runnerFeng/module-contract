pragma solidity ^0.4.0;


library ArrayUtils {

    function range(uint length) internal returns (uint[] memory r){
        r = new uint[](length);
        for (uint i = 0; i < length; i++) {
            r[i] = i;
        }

    }

    function map(uint[] memory self, function(uint) returns (uint) f) internal returns (uint[] memory r){
        r = new uint[](self.length);
        for (uint i = 0; i < self.length; i++) {
            r[i] = f(self[i]);
        }
    }

    function reduce(uint[] memory self, function(uint x, uint y)returns (uint) f) internal returns (uint r){
        r = self[0];
        for (uint i = 0; i < self.length; i++) {
            r = f(r, self[i]);
        }
    }


}


contract Pyramid {
    using ArrayUtils for *;

    function pyramid(uint length)returns (uint){
        ArrayUtils.range(length).map(square).reduce(sum);
    }

    function square(uint x) returns (uint){
        return x * x;
    }

    function sum(uint x, uint y)returns (uint){
        return x + y;
    }
}
