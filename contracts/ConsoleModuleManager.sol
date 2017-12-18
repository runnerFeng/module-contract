pragma solidity ^0.4.2;


import "./sysbase/OwnerNamed.sol";
import "./sysbase/BaseModule.sol";


contract ConsoleModuleManager is BaseModule {

    using LibString for *;
    using LibInt for *;

    string moduleName;

    string moduleVersion;

    string contractName;

    string contractVersion;

    string sysModuleId;

    uint reversion;

    // contractName => contractId ,eg : UserMananger => contract001
    mapping (string => string) innerContractMapping;

    enum MODULE_ERROR {
    NO_ERROR
    }

    enum ROLE_DEFINE {
    ROLE_SUPER,
    ROLE_ADMIN,
    ROLE_PLAIN
    }

    event Notify(uint _error, string _info);

    function ConsoleModuleManager(){
        reversion = 0;
        moduleName = "SystemModuleManager";
        //设置模块名称【根据实际修改】
        moduleVersion = "0.0.1.0";
        //设置模块版本号
        sysModuleId = moduleName.concat("_", moduleVersion);
        //显示指定模块ID

        string memory _json = "{";
        _json = _json.concat("\"moduleName\":\"", moduleName, "\",");
        _json = _json.concat("\"moduleVersion\":\"", moduleVersion, "\",");
        _json = _json.concat("\"icon\":\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA4ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMDY3IDc5LjE1Nzc0NywgMjAxNS8wMy8zMC0yMzo0MDo0MiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDoyNTBjNTFiOS1jMDc2LWM4NGEtOWEyOS1mMTNjMGY3NGExNjIiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDg5QkFEN0E3QTk0MTFFNzlBRjVBNzc2RDE2RThBQUQiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDg5QkFENzk3QTk0MTFFNzlBRjVBNzc2RDE2RThBQUQiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKE1hY2ludG9zaCkiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDoyYWQ1MGExYy1lY2Y4LTRiYTYtYmZjNy02Y2VlMmVhMDQ2YWIiIHN0UmVmOmRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDowZWU4MWJlYS1iZTI2LTExN2EtYmY4YS05ZWFhNmVmNDVmM2QiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7MPbc/AAAEF0lEQVR42sSZWUhVURSGz71p5FhmFlYmRTlkUtANw7c0IvIhJMiiwayHspF8DDLKnoIeRH2IsjkbycKKoMHHMk0qG9SHCLWssMk0QUv7F/wnDod7z3TvsQUf595z9t3r9+y911576WloaFAcmBcsAkuAD6SAaSCKz/vBe9AOmkA9aATDdh2F2Ww/HewA68AP8ABcBa2gE/SxXTRIAqkgG5wA48EFUAW6Qi0wHhwCa8FpkAdaDNp/Jc/BFd7LBEXgBbgISsEXK0NlZqvBK/CHQ1liIi6QtfC3c9iX9Flg9iOPwRyUt1sBcjmkjUpoTeZuDafJLvDbzhuMBLUgmR2FWpzCxeOjj1r6tCQwjHNEVuJK0Ku4Z7300U+fYVYEVsrQg41gSHHfhujLQ9+GAgs459aDQWX0bJA+cxkp/AqUUFIO1rg8rEbDvYYaEvwJPMyg+9Sph4iIiMngLhgGH8EGm12I70ugTB9mZoBnjHM9QQi8hssqzS3Z2jIGBgZabXQziVvkAtChvsFicCYYcZrYpp9CPpt99HC3KlY78HKCVocotim6N9jkoJ9qavKqWYls/C9DIHA7uAdGwCfZe20Or2qyDX4XbRIYc9ipkzk3WzIWiLgt33H9jMsy3Pfi83CQf+x9SefkDS4Ejx2Kk+G7hc/7tM9CIE6hJp+XOdsbm+Ik37vBHE+sDPeWB2ibCZpAsU2BoilVBCaCDzbEeTiJM3SrtQbPZunaTsSljqNUge9ZNgRKRp4oHceAnzZ+WMIcUW9x4DpERFLcGCYAyXwu38/hfpRFP6IpRo2DIxbfnpxBjhg0mQ+O8fNBWTC655KsHrUzzrKTSGBMMwvSECdnjGZGejO7bJIt52Eh3bFwzGiTN9gNppqIGyfDZ1GcYiGVP4k+E0zayCmxWwS2gXSTxlUOtiwjm6KZCoEsTX2DkkEsNnh7W3HZ7EJ6lY++iwyei6YmLw/VSwOIy+LByS0rh4+ZAZ6JpnoR+ARM0MU11U6BcBcFSog77ud+BsNWo5cZx3mwxU/DdMV9y/Fzbws1DXs1i6DQzyptHgWB7/wkrIXU9C/l72KqXaprvMlhFcGqvWU5RGv7WS7p0lcWJDC+BiuCOZcEabJnSwCfq9ZttIcmubGH+2fsfxAXS997tUUl/blYhvmhbOour169hdNnPes1hpWF3byeHSWRqjiFRSTT0scgT/eSjN50ebhj6SOaPgetVrd+sajToalChdp87Ft85NOn5fKbWtTZxtBTx5JEfAiEqSUW6fMAfQQsUlmpsMrCkfLtWJ74JeGc50BYBn/bzr4yuWpNE1Y7TqSIvpOH6m88Gj5iytapOTrIHpvEUko2N/44bl+Vio0iuifIf0PkMLimUHw0n/dRRDuDvoQuR/+G+CvAAGjg+nJ1aHTpAAAAAElFTkSuQmCC\"", ",");
        _json = _json.concat("\"moduleUrl\":\"http://192.168.9.18/dapp-console/#\"", ",");
        _json = _json.concat("\"moduleText\":\"控制台\"");
        _json = _json.concat("}");

        uint isExists = moduleIsExist(sysModuleId);
        uint ret = 0;
        if (isExists != 1) {
            log("publish console module , exec update ...");
            log("+++++++++++++ updModule param +++++++++++++++++++++++");
            log(_json);
            ret = updModule(_json);
        }

        // init menu data
        initMenuData();

        // add new action to role
        initAddActionToRole();

    }

    // 初始化DAPP-Console的菜单数据
    function initMenuData() private returns (uint) {
        log("init menu data ", "ConsoleModuleManager");
        string memory jsonStr = "";
        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300000\",\"name\":\"首页\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":1,\"parentId\":\"0\",\"url\":\"/user-welcome\",\"description\":\"\",\"resKey\":\"\",\"opKey\":\"1\",\"type\":1,\"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);

        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300001\",\"name\":\"管理与查询\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":1,\"parentId\":\"0\",\"url\":\"/manage\",\"description\":\"\",\"resKey\":\"\",\"opKey\":\"1\",\"type\":1,\"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);
        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300002\",\"name\":\"链管理\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":2,\"parentId\":\"action300001\",\"url\":\"/manage/chain\",\"description\":\"\",\"resKey\":\"\",\"opKey\":\"2\",\"type\":1,\"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);
        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300003\",\"name\":\"节点管理\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":2,\"parentId\":\"action300001\",\"url\":\"/manage/node\",\"description\":\"\",\"resKey\":\"\",\"opKey\":\"2\",\"type\":1,\"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);
        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300004\",\"name\":\"节点申请记录\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":2,\"parentId\":\"action300001\",\"url\":\"/manage/record\",\"description\":\"\",\"resKey\":\"\",\"opKey\":\"2\",\"type\":1,\"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);
        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300005\",\"name\":\"节点审核\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":2,\"parentId\":\"action300001\",\"url\":\"/manage/audit\",\"description\":\"\",\"resKey\":\"\",\"opKey\":\"2\",\"type\":1,\"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);
        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300006\",\"name\":\"区块查询\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":2,\"parentId\":\"action300001\",\"url\":\"/manage/block\",\"description\":\"\",\"resKey\":\"\",\"opKey\":\"2\",\"type\":1,\"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);
        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300007\",\"name\":\"交易查询\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":2,\"parentId\":\"action300001\",\"url\":\"/manage/trade\",\"description\":\"\",\"resKey\":\"\",\"opKey\":\"2\",\"type\":1,\"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);
        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300008\",\"name\":\"DAPP查询\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":2,\"parentId\":\"action300001\",\"url\":\"/manage/dapp\",\"description\":\"\",\"resKey\":\"\",\"opKey\":\"2\",\"type\":1,\"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);
        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300009\",\"name\":\"合约查询\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":2,\"parentId\":\"action300001\",\"url\":\"/manage/contract\",\"description\":\"\",\"resKey\":\"\",\"opKey\":\"2\",\"type\":1,\"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);

        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300020\",\"name\":\"权限\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":\"1\",\"parentId\":\"0\",\"url\":\"/rolemgr\",\"description\":\"\",\"resKey\":\"\",\"opKey\":\"2\", \"type\":\"1\",\"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);
        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300021\",\"name\":\"角色\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":\"2\",\"parentId\":\"action300020\",\"url\":\"/rolemgr\",\"description\":\"\",\"resKey\":\"角色\",\"opKey\":\"2\",\"type\":\"1\", \"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);
        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300022\",\"name\":\"组织用户与权限\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":\"2\",\"parentId\":\"action300020\",\"url\":\"/rolemgr/organUser\",\"description\":\"\",\"resKey\":\"组织用户与权限\",\"opKey\":\"3\",\"type\":\"1\", \"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);
        jsonStr = "{\"moduleName\":\"SystemModuleManager\",\"moduleVersion\":\"0.0.1.0\",\"id\":\"action300023\",\"name\":\"用户注册审核\",\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"enable\":1,\"level\":\"2\",\"parentId\":\"action300020\",\"url\":\"/rolemgr/audit\",\"description\":\"\",\"resKey\":\"用户注册审核\",\"opKey\":\"3\",\"type\":\"1\", \"version\":\"0.0.1.0\"}";
        addMenu(jsonStr);

        log("init menu data complete..", "ConsoleModuleManager");
        return 1;
    }

    // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    // +++++++++++++++++++++++ init role ++++++++++++++++++++++++++++++++++++++++
    function initRoleData() private returns (uint) {
        /* log("init role data ","SystemModuleManager");
        string memory roleJsonStr="";
        roleJsonStr="{\"id\":\"role100000\",\"name\":\"节点管理员\",\"status\":1,\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"description\":\"节点管理员\",\"actionIdList\":[\"action7000\",\"action7001\",\"action7002\",\"action7003\",\"action7004\",\"action7005\",\"action7006\",\"action7007\",\"action7008\",\"action7009\",\"action7010\",\"action7011\",\"action7012\",\"action7013\",\"action7014\",\"action7015\",\"action7016\",\"action7017\",\"action7018\",\"action7019\",\"action7020\",\"action7021\",\"action7022\",\"action7023\",\"action1001\",\"action1002\",\"action1003\",\"action1004\",\"action1005\",\"action1006\",\"action1007\",\"action1008\",\"action1009\",\"action1010\",\"action1011\",\"action1012\",\"action1013\",\"action1014\",\"action1015\",\"action1016\",\"action1017\",\"action1018\",\"action1019\",\"action1020\",\"action1021\",\"action1022\",\"action1023\",\"action1024\",\"action1025\",\"action1026\",\"action1027\",\"action1028\",\"action1029\",\"action1030\",\"action1031\",\"action1032\",\"action1033\",\"action1034\",\"action1035\",\"action1036\",\"action1037\",\"action1038\",\"action1039\",\"action1040\",\"action1041\",\"action1042\",\"action1043\",\"action1044\",\"action1045\",\"action1046\",\"action1047\",\"action1048\",\"action1049\",\"action1050\",\"action1051\",\"action1052\",\"action1053\",\"action1054\",\"action1055\",\"action1056\",\"action1057\",\"action1058\",\"action1059\",\"action1060\",\"action2001\",\"action2002\",\"action2003\",\"action2004\",\"action2005\",\"action2006\",\"action2007\",\"action2008\",\"action2009\",\"action2010\",\"action2011\",\"action2012\",\"action2013\",\"action2014\",\"action2015\",\"action2016\",\"action2017\",\"action2018\",\"action2019\",\"action2020\",\"action2021\",\"action2022\",\"action2023\",\"action2024\",\"action2025\",\"action2026\",\"action2027\",\"action2028\",\"action2029\",\"action2030\",\"action2031\",\"action2032\",\"action2033\",\"action2034\",\"action2035\",\"action2036\",\"action2037\",\"action2038\",\"action2039\",\"action2040\",\"action2041\",\"action2042\",\"action2043\",\"action2044\",\"action2045\",\"action2046\",\"action2047\",\"action2048\",\"action3000\",\"action3001\",\"action3002\",\"action3003\",\"action3004\",\"action3005\",\"action3006\",\"action3007\",\"action3008\",\"action3009\",\"action3010\",\"action3011\",\"action3012\",\"action4000\",\"action4001\",\"action4002\",\"action4003\",\"action4004\",\"action4005\",\"action4006\",\"action4007\",\"action4008\",\"action4009\",\"action4010\",\"action4011\",\"action4012\",\"action4013\",\"action4014\",\"action4015\",\"action4016\",\"action4017\",\"action4018\",\"action4019\",\"action4020\",\"action4021\",\"action4022\",\"action4023\",\"action4024\",\"action4025\",\"action4026\",\"action4027\",\"action4028\",\"action4029\",\"action4030\",\"action4031\",\"action4032\",\"action4033\",\"action4034\",\"action4035\",\"action4036\",\"action300001\",\"action100011\",\"action300003\",\"action300004\",\"action300006\",,\"action100018\",\"action300007\",\"action300008\",\"action300009\",\"action300000\"]}";
        addRole(roleJsonStr);
        roleJsonStr="{\"id\":\"role100001\",\"name\":\"链管理员\",\"status\":1,\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"description\":\"链管理员\",\"actionIdList\":[\"action100011\",\"action100018\",\"action5000\",\"action5001\",\"action5002\",\"action5003\",\"action5004\",\"action5005\",\"action5006\",\"action5007\",\"action5008\",\"action5009\",\"action5010\",\"action5011\",\"action5012\",\"action5013\",\"FileInfoManager_getErrno\",\"FileInfoManager_stringToUint\",\"FileInfoManager_listByGroup\",\"FileInfoManager_deleteById\",\"FileInfoManager_pageByGroup\",\"FileInfoManager_update\",\"FileInfoManager_register\",\"FileInfoManager_generateFileID\",\"FileInfoManager_listAll\",\"FileInfoManager_getCurrentPageCount\",\"FileInfoManager_find\",\"FileInfoManager_getGroupPageCount\",\"FileInfoManager_getCount\",\"FileInfoManager_insert\",\"FileInfoManager_pageFiles\",\"FileInfoManager_getCurrentPageSize\",\"FileInfoManager_getGroupFileCount\",\"FileServerManager_getErrno\",\"FileServerManager_listByGroup\",\"FileServerManager_deleteById\",\"FileServerManager_update\",\"FileServerManager_listAll\",\"FileServerManager_isServerEnable\",\"FileServerManager_getCount\",\"FileServerManager_find\",\"FileServerManager_insert\",\"FileServerManager_enable\",\"FileServerManager_findIdByHostPort\",\"action1001\",\"action1002\",\"action1003\",\"action1004\",\"action1005\",\"action1006\",\"action1007\",\"action1008\",\"action1009\",\"action1010\",\"action1011\",\"action1012\",\"action1013\",\"action1014\",\"action1015\",\"action1016\",\"action1017\",\"action1018\",\"action1019\",\"action1020\",\"action1021\",\"action1022\",\"action1023\",\"action1024\",\"action1025\",\"action1026\",\"action1027\",\"action1028\",\"action1029\",\"action1030\",\"action1031\",\"action1032\",\"action1033\",\"action1034\",\"action1035\",\"action1036\",\"action1037\",\"action1038\",\"action1039\",\"action1040\",\"action1041\",\"action1042\",\"action1043\",\"action1044\",\"action1045\",\"action1046\",\"action1047\",\"action1048\",\"action1049\",\"action1050\",\"action1051\",\"action1052\",\"action1053\",\"action1054\",\"action1055\",\"action1056\",\"action1057\",\"action1058\",\"action1059\",\"action1060\",\"action2001\",\"action2002\",\"action2003\",\"action2004\",\"action2005\",\"action2006\",\"action2007\",\"action2008\",\"action2009\",\"action2010\",\"action2011\",\"action2012\",\"action2013\",\"action2014\",\"action2015\",\"action2016\",\"action2017\",\"action2018\",\"action2019\",\"action2020\",\"action2021\",\"action2022\",\"action2023\",\"action2024\",\"action2025\",\"action2026\",\"action2027\",\"action2028\",\"action2029\",\"action2030\",\"action2031\",\"action2032\",\"action2033\",\"action2034\",\"action2035\",\"action2036\",\"action2037\",\"action2038\",\"action2039\",\"action2040\",\"action2041\",\"action2042\",\"action2043\",\"action2044\",\"action2045\",\"action2046\",\"action2047\",\"action2048\",\"action3000\",\"action3001\",\"action3002\",\"action3003\",\"action3004\",\"action3005\",\"action3006\",\"action3007\",\"action3008\",\"action3009\",\"action3010\",\"action3011\",\"action3012\",\"action4000\",\"action4001\",\"action4002\",\"action4003\",\"action4004\",\"action4005\",\"action4006\",\"action4007\",\"action4008\",\"action4009\",\"action4010\",\"action4011\",\"action4012\",\"action4013\",\"action4014\",\"action4015\",\"action4016\",\"action4017\",\"action4018\",\"action4019\",\"action4020\",\"action4021\",\"action4022\",\"action4023\",\"action4024\",\"action4025\",\"action4026\",\"action4027\",\"action4028\",\"action4029\",\"action4030\",\"action4031\",\"action4032\",\"action4033\",\"action4034\",\"action4035\",\"action4036\",\"action300000\"]}";
        addRole(roleJsonStr);
        roleJsonStr="{\"id\":\"role100002\",\"name\":\"系统管理员\",\"status\":1,\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"description\":\"系统管理员\",\"actionIdList\":[\"action8000\",\"action8001\",\"action1001\",\"action1002\",\"action1003\",\"action1004\",\"action1005\",\"action1006\",\"action1007\",\"action1008\",\"action1009\",\"action1010\",\"action1011\",\"action1012\",\"action1013\",\"action1014\",\"action1015\",\"action1016\",\"action1017\",\"action1018\",\"action1019\",\"action1020\",\"action1021\",\"action1022\",\"action1023\",\"action1024\",\"action1025\",\"action1026\",\"action1027\",\"action1028\",\"action1029\",\"action1030\",\"action1031\",\"action1032\",\"action1033\",\"action1034\",\"action1035\",\"action1036\",\"action1037\",\"action1038\",\"action1039\",\"action1040\",\"action1041\",\"action1042\",\"action1043\",\"action1044\",\"action1045\",\"action1046\",\"action1047\",\"action1048\",\"action1049\",\"action1050\",\"action1051\",\"action1052\",\"action1053\",\"action1054\",\"action1055\",\"action1056\",\"action1057\",\"action1058\",\"action1059\",\"action1060\",\"action2001\",\"action2002\",\"action2003\",\"action2004\",\"action2005\",\"action2006\",\"action2007\",\"action2008\",\"action2009\",\"action2010\",\"action2011\",\"action2012\",\"action2013\",\"action2014\",\"action2015\",\"action2016\",\"action2017\",\"action2018\",\"action2019\",\"action2020\",\"action2021\",\"action2022\",\"action2023\",\"action2024\",\"action2025\",\"action2026\",\"action2027\",\"action2028\",\"action2029\",\"action2030\",\"action2031\",\"action2032\",\"action2033\",\"action2034\",\"action2035\",\"action2036\",\"action2037\",\"action2038\",\"action2039\",\"action2040\",\"action2041\",\"action2042\",\"action2043\",\"action2044\",\"action2045\",\"action2046\",\"action2047\",\"action2048\",\"action3000\",\"action3001\",\"action3002\",\"action3003\",\"action3004\",\"action3005\",\"action3006\",\"action3007\",\"action3008\",\"action3009\",\"action3010\",\"action3011\",\"action3012\",\"action4000\",\"action4001\",\"action4002\",\"action4003\",\"action4004\",\"action4005\",\"action4006\",\"action4007\",\"action4008\",\"action4009\",\"action4010\",\"action4011\",\"action4012\",\"action4013\",\"action4014\",\"action4015\",\"action4016\",\"action4017\",\"action4018\",\"action4019\",\"action4020\",\"action4021\",\"action4022\",\"action4023\",\"action4024\",\"action4025\",\"action4026\",\"action4027\",\"action4028\",\"action4029\",\"action4030\",\"action4031\",\"action4032\",\"action4033\",\"action4034\",\"action4035\",\"action4036\",\"action300000\"]}";
        addRole(roleJsonStr);
        roleJsonStr="{\"id\":\"role100003\",\"name\":\"权限管理员\",\"status\":1,\"moduleId\":\"systemModule001\",\"contractId\":\"\",\"description\":\"机构、用户权限管理员\",\"actionIdList\":[\"action2001\",\"action2002\",\"action2003\",\"action2004\",\"action2005\",\"action2006\",\"action2007\",\"action2008\",\"action2009\",\"action2010\",\"action2011\",\"action2012\",\"action2013\",\"action2014\",\"action2015\",\"action2016\",\"action2017\",\"action2018\",\"action2019\",\"action2020\",\"action2021\",\"action2022\",\"action2023\",\"action2024\",\"action2025\",\"action2026\",\"action2027\",\"action2028\",\"action2029\",\"action2030\",\"action2031\",\"action2032\",\"action2033\",\"action2034\",\"action2035\",\"action2036\",\"action2037\",\"action2038\",\"action2039\",\"action2040\",\"action2041\",\"action2042\",\"action2043\",\"action2044\",\"action2045\",\"action2046\",\"action2047\",\"action2048\",\"action1001\",\"action1002\",\"action1003\",\"action1004\",\"action1005\",\"action1006\",\"action1007\",\"action1008\",\"action1009\",\"action1010\",\"action1011\",\"action1012\",\"action1013\",\"action1014\",\"action1015\",\"action1016\",\"action1017\",\"action1018\",\"action1019\",\"action1020\",\"action1021\",\"action1022\",\"action1023\",\"action1024\",\"action1025\",\"action1026\",\"action1027\",\"action1028\",\"action1029\",\"action1030\",\"action1031\",\"action1032\",\"action1033\",\"action1034\",\"action1035\",\"action1036\",\"action1037\",\"action1038\",\"action1039\",\"action1040\",\"action1041\",\"action1042\",\"action1043\",\"action1044\",\"action1045\",\"action1046\",\"action1047\",\"action1048\",\"action1049\",\"action1050\",\"action1051\",\"action1052\",\"action1053\",\"action1054\",\"action1055\",\"action1056\",\"action1057\",\"action1058\",\"action1059\",\"action1060\",\"action100019\",\"action100020\",\"action100021\",\"action6000\",\"action6001\",\"action6002\",\"action6003\",\"action6004\",\"action6005\",\"action6006\",\"action6007\",\"action6008\",\"action6009\",\"action6010\",\"action6011\",\"action6012\",\"action6013\",\"action6014\",\"action6015\",\"action6016\",\"action6017\",\"action6018\",\"action3000\",\"action3001\",\"action3002\",\"action3003\",\"action3004\",\"action3005\",\"action3006\",\"action3007\",\"action3008\",\"action3009\",\"action3010\",\"action3011\",\"action3012\",\"action4000\",\"action4001\",\"action4002\",\"action4003\",\"action4004\",\"action4005\",\"action4006\",\"action4007\",\"action4008\",\"action4009\",\"action4010\",\"action4011\",\"action4012\",\"action4013\",\"action4014\",\"action4015\",\"action4016\",\"action4017\",\"action4018\",\"action4019\",\"action4020\",\"action4021\",\"action4022\",\"action4023\",\"action4024\",\"action4025\",\"action4026\",\"action4027\",\"action4028\",\"action4029\",\"action4030\",\"action4031\",\"action4032\",\"action4033\",\"action4034\",\"action4035\",\"action4036\",\"action300000\",\"action100019\",\"action100020\",\"action100021\",\"action3000013\"]}";
        addRole(roleJsonStr);
        log("init role data completed...");
        return 1; */
    }

    function initAddActionToRole() private returns (uint) {
        // role100000 -> 节点管理员 
        // role100001 -> 链管理员
        // role100002 -> 系统管理员
        // role100003 -> 权限管理员
        string memory _roleId = "role100000";
        string[7] memory actionIds = ["action300000", "action300001", "action300003", "action300004", "action300006", "action300007", "action300009"];
        for (uint i = 0; i < actionIds.length; i++) {
            addActionToRole(sysModuleId, _roleId, actionIds[i]);
        }
        log("add action to role for role100000 success.");

        // 新增权限到链管理员
        _roleId = "role100001";
        string[4] memory actionIds2 = ["action300000", "action300002", "action300005", "action300008"];
        for (i = 0; i < actionIds2.length; i++) {
            addActionToRole(sysModuleId, _roleId, actionIds2[i]);
        }

        // 新增权限到角色管理员
        _roleId = "role100003";
        string[4] memory actionIds3 = ["action300020", "action300021", "action300022", "action300023"];
        for (i = 0; i < actionIds3.length; i++) {
            addActionToRole(sysModuleId, _roleId, actionIds3[i]);
        }
        log("------------------- initAddActionToRole succ.-----------------------");
    }
}
