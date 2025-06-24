// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {VRFConsumerBaseV2Plus} from "@chainlink/contracts@1.3.0/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "@chainlink/contracts@1.3.0/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";

/**
 * @title Simple Lottery using Chainlink VRF v2.5
 * @notice Users enter the lottery, and a random winner is picked using Chainlink VRF
 */
contract Lottery is VRFConsumerBaseV2Plus {
    // Chainlink VRF settings
    uint256 public s_subscriptionId;
    address public constant VRF_COORDINATOR = 0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B;
    bytes32 public constant KEY_HASH = 0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae;

    uint32 public callbackGasLimit = 100000;
    uint16 public requestConfirmations = 3;
    uint32 public numWords = 1;

    // Lottery state
    address[] public players;
    address public winner;
    bool public lotteryOpen = true;

    // VRF mappings
    mapping(uint256 => bool) public requestFulfilled;

    // Events
    event PlayerEntered(address indexed player);
    event WinnerRequested(uint256 indexed requestId);
    event WinnerSelected(address indexed winner, uint256 indexed requestId);
    event LotteryReset();
    event LotteryClosed();

    /**
     * @dev Constructor to initialize Chainlink VRF subscription
     * @param subscriptionId Your Chainlink VRF v2.5 subscription ID
     */
    constructor(uint256 subscriptionId) VRFConsumerBaseV2Plus(VRF_COORDINATOR) {
        s_subscriptionId = subscriptionId;
    }

    /**
     * @notice Enter the lottery by calling this function
     * Emits PlayerEntered event on success
     */
    function enter() public {
        require(lotteryOpen, "Lottery is closed");
        players.push(msg.sender);
        emit PlayerEntered(msg.sender);
    }

    /**
     * @notice Request random number from Chainlink VRF to pick a winner
     * Emits WinnerRequested and LotteryClosed events
     * @return requestId The Chainlink VRF request ID
     */
    function requestWinner() public returns (uint256 requestId) {
        require(players.length > 0, "No players");
        require(lotteryOpen, "Winner already requested");

        lotteryOpen = false;
        emit LotteryClosed();

        requestId = s_vrfCoordinator.requestRandomWords(
            VRFV2PlusClient.RandomWordsRequest({
                keyHash: KEY_HASH,
                subId: s_subscriptionId,
                requestConfirmations: requestConfirmations,
                callbackGasLimit: callbackGasLimit,
                numWords: numWords,
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
            })
        );

        emit WinnerRequested(requestId);
    }

    /**
     * @notice Callback function called by VRF Coordinator with random words
     * Emits WinnerSelected event when winner is chosen
     * @param requestId The Chainlink VRF request ID
     * @param randomWords Array of random numbers
     */
    function fulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) internal override {
        require(players.length > 0, "No players");

        uint256 winnerIndex = randomWords[0] % players.length;
        winner = players[winnerIndex];
        requestFulfilled[requestId] = true;

        emit WinnerSelected(winner, requestId);
    }

    /**
     * @notice View all current lottery players
     * @return address[] memory Array of player addresses
     */
    function getPlayers() public view returns (address[] memory) {
        return players;
    }

    /**
     * @notice Reset the lottery to start a new round
     * Can only be called when the lottery is closed
     * Emits LotteryReset event
     */
    function resetLottery() public {
        require(!lotteryOpen, "Lottery already open");

        delete players;
        winner = address(0);
        lotteryOpen = true;

        emit LotteryReset();
    }
}
