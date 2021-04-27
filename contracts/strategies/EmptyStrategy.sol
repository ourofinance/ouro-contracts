// SPDX-License-Identifier: MIT

pragma solidity 0.7.6;

import "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

import "../interfaces/IWBNB.sol";

contract EmptyStrategy is Ownable, Pausable, ReentrancyGuard {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;
    using Address for address;

    /* ========== STATE VARIABLES ========== */

    // wbnb
    address public wbnb;
    // Dev address
    address public devaddr;
    // Accepted token
    address public wantToken;
    // is BNB
    bool public isBNB;

    /* ========== CONSTRUCTOR ========== */

    constructor(address _devaddr, address _wantToken) public {
        wbnb = address(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);

        devaddr = _devaddr;
        wantToken = _wantToken;

        if (wbnb == _wantToken) {
            isBNB = true;
        } else {
            isBNB = false;
        }
    }

    /* ========== VIEW FUNCTIONS ========== */

    function deposit(uint256 _amount) public onlyOwner nonReentrant whenNotPaused returns (uint256) {
        if (isBNB) {
            _wrapBNB(_amount);
        }
        IERC20(wantToken).safeTransferFrom(address(msg.sender), address(this), _amount);
    }

    function withdraw(uint256 _amount) public onlyOwner nonReentrant returns (uint256) {
        if (isBNB) {
            _unwrapBNB(_amount);
        }
        IERC20(wantToken).safeTransfer(address(msg.sender), _amount);
    }

    function _wrapBNB(uint256 _amount) internal virtual {
        // BNB -> WBNB
        IWBNB(wbnb).deposit{value: _amount}();
    }

    function _unwrapBNB(uint256 _amount) internal virtual {
        // WBNB -> BNB
        IWBNB(wbnb).withdraw(_amount);
    }

    /* ========== GOVERNANCE ========== */

    function migrate(address _target) public onlyOwner {
        uint256 balance = IERC20(wantToken).balanceOf(address(this));
        IERC20(wantToken).safeTransfer(_target, balance);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }
}
