pragma solidity ^0.4.0;


contract CrowdFunding {
    //investor
    struct Funder {
    address addr;
    uint amount;
    }

    //activity
    struct Campaign {
    address beneficiary;
    uint goal;
    uint amount;
    uint fundNum;
    mapping (uint => Funder) funders;
    }

    uint campaignID;

    mapping (uint => Campaign) campaigns;

    //候选人
    function candidate(address beneficiary, uint goal)returns (uint campaignID){
        //initialize
        campaigns[campaignID++] = Campaign(beneficiary, goal, 0, 0);
    }

    function vote(uint campaignID) payable {
        Campaign c = campaigns[campaignID];

        //another way to initialize
        c.funders[c.fundNum] = Funder({addr : msg.sender, amount : msg.value});
        c.amount += msg.value;
    }

    function check(uint campaignID) returns (bool){
        Campaign c = campaigns[campaignID];
        if (c.amount < c.goal) {
            return false;
        }

        //引用拷贝
        uint amount = c.amount;
        c.amount = 0;
        if (!c.beneficiary.send(amount)) {
            throw;
        }
        return true;
    }

}
