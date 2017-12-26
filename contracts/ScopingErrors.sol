pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/21 10:04
 * Desc:
 */
contract ScopingErrors {
    function scoping() {
        uint i = 0;

        while (i++ < 1) {
            uint same1 = 0;
        }

        while (i++ < 2) {
            uint same1 = 0;
            // Illegal, second declaration of same1
        }
    }

    function minimalScoping() {
        {
            uint same2 = 0;
        }

        {
            uint same2 = 0;
            // Illegal, second declaration of same2
        }
    }

    function forLoopScoping() {
        for (uint same3 = 0; same3 < 1; same3++) {
        }

        for (uint same3 = 0; same3 < 1; same3++) {// Illegal, second declaration of same3
        }
    }

    function crossFunction(){
        uint same1 = 0;
        //Illegal
    }

}
