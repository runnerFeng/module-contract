pragma solidity ^0.4.0;


contract SimpleAction {
    //a simple event
    event aNewHigherBid(address bidder, uint amount);

    function bid(uint bidValue) external {
        aNewHigherBid(msg.sender, bidValue);
    }

}
