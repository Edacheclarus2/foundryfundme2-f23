// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract MockV3Aggregator {
    uint256 public constant version = 4;

    uint8 public decimals;
    int256 public latestAnswer;
    uint256 public latestTimeStamp;
    uint256 public latestRound;

    mapping(uint256 => int256) public getAnswer;
    mapping(uint256 => uint256) public getTimeStamp;
    mapping(uint256 => uint256) public getStartedAt;

    constructor(uint8 _decimals, int256 _initialAnswer) {
        decimals = _decimals;
        updateAnswer(_initialAnswer);
    }

    function updateAnswer(int256 _answer) public {
        latestAnswer = _answer;
        latestTimeStamp = block.timestamp;
        latestRound++;
        getAnswer[latestRound] = _answer;
        getTimeStamp[latestRound] = block.timestamp;
        getStartedAt[latestRound] = block.timestamp;
    }

    function updateRoundData(
        uint80 _roundId,
        int256 _answer,
        uint256 _timestamp,
        uint256 _startedAt
    ) public {
        latestRound = _roundId;
        latestAnswer = _answer;
        latestTimeStamp = _timestamp;
        getAnswer[latestRound] = int256(_timestamp);
        getTimeStamp[latestRound] = _timestamp;
        getStartedAt[latestRound] = _startedAt;
    }

    function getRoundData(
        uint80 _roundId
    )
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        return (
            _roundId,
            getAnswer[_roundId],
            getStartedAt[_roundId],
            getTimeStamp[_roundId],
            _roundId
        );
    }

    function latestRoundData() external view // returns (
    //     uint80 roundId,
    //     int256 answer,
    //     uint256 startedAt,
    //     uint256 updatedAt,
    //     uint80 answeredInRound
    // )
    {
        uint80(latestRound);
        getAnswer[latestRound];
        getStartedAt[latestRound];
        getTimeStamp[latestRound];
        uint80(latestRound);
    }

    function description() external pure returns (string memory) {
        return "v0.6/tests/mockV3Aggregator.sol";
    }
}
