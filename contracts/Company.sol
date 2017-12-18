pragma solidity ^0.4.0;


contract Company {
    //struct type
    struct employee {
    string name;
    uint age;
    uint salary;
    }

    struct manager {
    employee employ;
    string title;
    }
}
