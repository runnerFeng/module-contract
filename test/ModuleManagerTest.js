contract('JuzixToken', function (accounts) {

    var fromJson = {from: "0x02fe6939a87c49650fc9efb8ce2864bf6d4644ca"};
    var addr = "0x02fe6939a87c49650fc9efb8ce2864bf6d4644ca";

    it("module query...", function () {
        var registerManger = IRegisterManager.at("0x0000000000000000000000000000000000000011");
        return registerManger.getContractAddress.call("RoleFilterManager", "0.0.1.0", fromJson).then(function (result) {
            console.log("============  module query ===================");
            console.log("合约地址：" + result);
            return result;
        }).then(function (result) {
            var roleFilterManager = IRoleFilterManager.at(result);
            return roleFilterManager.listAll.call(fromJson);
        }).then(function (result) {
            console.log("++++++++++++++++++++++++" + result);
        });
    });

});
