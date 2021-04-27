// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/SafeCast.sol";

import "@chainlink/contracts/src/v0.7/interfaces/AggregatorV3Interface.sol";

import "./BnbUsdOracle.sol";

contract ChainlinkOracle is BnbUsdOracle {
    using SafeMath for uint256;
    using Address for address;
    using SafeCast for int256;

    /* ========== STATE VARIABLES ========== */
    // Chainlink price feeder, maybe bnb base or usd base
    address public feeder;
    // feeder is usd base
    bool public usdBase;

    /* ========== CONSTRUCTOR ========== */
    constructor(address _feeder, bool _usdBase) public {
        require(_feeder.isContract(), "feeder invalid");

        feeder = _feeder;
        usdBase = _usdBase;
    }

    /* ========== VIEW FUNCTIONS ========== */

    /* ========== GOVERNANCE ========== */
    function setFeeder(address _feeder, bool _usdBase) public onlyOwner {
        require(_feeder.isContract(), "feeder invalid");

        feeder = _feeder;
        usdBase = _usdBase;
    }
}
