// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ITreasureManager {

    event DepositToken(
        address indexed tokenAddress,
        address indexed sender,
        uint256 amount
    );
    event WithdrawToken(
        address indexed tokenAddress,
        address sender,
        address withdrawAddress,
        uint256 amount
    );
    event WithdrawManagerUpdate(
        address indexed withdrawManager
    );
    event GrantRewardTokenAmount(
        address indexed tokenAddress,
        address granter,
        uint256 amount
    );

    function depositETH() external payable returns (bool);
    function depositERC20(IERC20 tokenAddress, uint256 amount) external returns (bool);
    function grantRewards(address tokenAddress, address receiptAddress, uint256 amount) external;
    function claimToken(address tokenAddress) external;
    function withdrawETH(address payable withdrawAddress, uint256 amount) external payable returns (bool);
    function withdrawERC20(IERC20 tokenAddress, address withdrawAddress, uint256 amount) external returns (bool);
    function setTokenWhiteList(address tokenAddress) external;
    function setWithdrawManager(address _withdrawManager) external;
    function queryRewards(address tokenAddress) external view returns (uint256);
    // function getValue() external pure returns (uint256);
}
