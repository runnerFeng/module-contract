pragma solidity ^0.4.0;
/**
 * @author jinx
 * @date 2017/12/20 16:11
 * Desc:
 */

contract Account {
    uint accId;

    function Account(uint accountId) payable {
        accId = accountId;
    }
}


contract initialize {

    Account account = new Account(10);

    function newAccount(uint accountId){
        account = new Account(accountId);
    }

    function newAccountWithEther(uint accountId, uint amount){
        amount = new Account.value(amount)(amountId);
    }

}