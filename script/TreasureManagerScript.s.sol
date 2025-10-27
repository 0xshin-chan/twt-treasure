// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/TreasureManager.sol";
import "../test/EmptyContract.sol";
import "forge-std/Vm.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";


contract TreasureManagerScript is Script {
    EmptyContract public emptyContract;
    TreasureManager public treasureManager;
    TreasureManager public treasureManagerImplementation;
    ProxyAdmin public treasureManagerProxyAdmin;

    function run() public {
        uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployAddress = vm.addr(deployPrivateKey);

        vm.startBroadcast();

        emptyContract = new EmptyContract();
        TransparentUpgradeableProxy proxyTreasureManager = new TransparentUpgradeableProxy(address(emptyContract), deployAddress, "");
        treasureManager = TreasureManager(payable(proxyTreasureManager));

        treasureManagerImplementation = new TreasureManager();
        treasureManagerProxyAdmin = ProxyAdmin(getProxyAdminAddress(address(proxyTreasureManager)));

        treasureManagerProxyAdmin.upgradeAndCall(
            ITransparentUpgradeableProxy(address(treasureManager)),
            address(treasureManagerImplementation),
            abi.encodeWithSelector(
                TreasureManager.initialize.selector,
                msg.sender,
                msg.sender,
                msg.sender
            )
        );

        console.log("address=====", address(treasureManager));
        console.log("treasureManagerProxyAdmin=====", address(treasureManagerProxyAdmin));

        vm.stopBroadcast();
    }

    function getProxyAdminAddress(address proxy) internal view returns (address) {
        address CHEATCODE_ADDRESS = 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D;
        Vm vm = Vm(CHEATCODE_ADDRESS);
        bytes32 adminSlot = vm.load(proxy, ERC1967Utils.ADMIN_SLOT);
        return address(uint160(uint256(adminSlot)));
    }
}
