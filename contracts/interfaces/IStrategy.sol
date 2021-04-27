// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

// For interacting with strategy
interface IStrategy {
    // Total want tokens managed by stratfegy
    function wantLockedTotal() external view returns (uint256);

    // Sum of all shares of users to wantLockedTotal
    function sharesTotal() external view returns (uint256);

    // Main want token compounding function
    function earn() external;

    // Transfer want tokens Pool -> Strategy
    function deposit(address _playerAddress, uint256 _amount) external returns (uint256);

    // Transfer want tokens Strategy -> Pool
    function withdraw(address _playerAddress, uint256 _amount) external returns (uint256);

    function pause() external;

    function unpause() external;
}
