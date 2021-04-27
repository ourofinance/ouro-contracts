// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

import "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/SafeCast.sol";

import "@chainlink/contracts/src/v0.7/interfaces/AggregatorV3Interface.sol";

contract BnbUsdOracle is Ownable {
    using SafeMath for uint256;
    using Address for address;
    using SafeCast for int256;

    /* ========== STATE VARIABLES ========== */
    // Chainlink BNB/USD price feeder
    address public bnbUsdFeeder;

    /* ========== CONSTRUCTOR ========== */
    constructor() public {
        bnbUsdFeeder = address(0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE);
    }

    /* ========== VIEW FUNCTIONS ========== */
    function getBnbUsdPrice() public view returns (uint256, uint256) {
        AggregatorV3Interface _bnbUsdFeeder = AggregatorV3Interface(bnbUsdFeeder);
        // (
        //     uint80 roundID,
        //     int256 price,
        //     uint256 startedAt,
        //     uint256 timeStamp,
        //     uint80 answeredInRound
        // ) = _feeder.latestRoundData();

        (, int256 price, , uint256 timeStamp, ) = _bnbUsdFeeder.latestRoundData();

        require(timeStamp > 0, "bnbusd round not complete");

        return (price.toUint256(), _bnbUsdFeeder.decimals());
    }

    /* ========== GOVERNANCE ========== */
    function setBnbUsdFeeder(address _bnbUsdFeeder) public onlyOwner {
        require(_bnbUsdFeeder.isContract(), "bnb usd feeder invalid");

        bnbUsdFeeder = _bnbUsdFeeder;
    }
}
