module.exports = function (deployer) {

    // 发布DAPP
    deployer.deploy(ConsoleModuleManager);
    //deployer.deploy(MonitorModuleManager);

    deployer.autolink();

};
