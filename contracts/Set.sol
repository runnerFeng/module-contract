pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/26 17:29
 * Desc:
 */

library Set {
    struct Data {
        mapping(uint => bool) flags;
    }

    function insert(Data storage self, uint value)returns (bool){
        if (self.flags[value]) {
            //already there
            return false;
        }
        self.falgs[value] = true;
        return true;
    }

    function remove(Data storage self, uint value)returns (bool){
        if (!self.flags[value]) {
            return false;
        }
        self.flags[value] = false;
        return true;
    }

    function contains(Data storage sele, uint value)returns (bool){
        return self.flags[value];
    }

}

contract C {
    Set.Data knowValues;

    function register(uint value) {
        // The library functions can be called without a
        // specific instance of the library, since the
        // "instance" will be the current contract.
        if (!Set.insert(knowValues, value)) {
            throw;
        }
        // In this contract, we can also directly access knownValues.flags, if we want.
    }

}
