pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/26 18:07
 * Desc:
 */

library BigInt {
    struct bigint {
        uint[] limbs;
    }

    function fromUint(uint x)returns (bigint r){
        r.limbs = new uint[](1);
        r.limbs[0] = x;
    }

    function add(bigint _a, bigint _b) internal returns (bigint r){
        r.limbs = new uint[](max(_a.limbs.length(), _b.limbs.length()));
        uint carry = 0;
        for (uint i = 0; i < r.limbs.length(); ++i) {

        }
    }
}
