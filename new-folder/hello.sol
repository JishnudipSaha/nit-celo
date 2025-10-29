// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title RedCard
 * @dev Immutable tracking of fouls and player violations.
 * Each player’s foul record is stored permanently on the blockchain.
 */
contract RedCard {

    // Owner (referee / admin) who controls foul logging
    address public owner;

    // Structure to store player data
    struct Player {
        uint256 yellowCards;
        uint256 redCards;
        bool exists;
    }

    // Mapping player address -> Player record
    mapping(address => Player) private players;

    // Events for transparency
    event YellowCardIssued(address indexed player, uint256 totalYellowCards);
    event RedCardIssued(address indexed player, uint256 totalRedCards);
    event PlayerRegistered(address indexed player);

    constructor() {
        owner = msg.sender; // contract deployer is the admin
    }

    // Modifier: only the owner can record fouls
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // Register a new player before tracking
    function registerPlayer(address _player) public onlyOwner {
        require(!players[_player].exists, "Player already registered");
        players[_player] = Player(0, 0, true);
        emit PlayerRegistered(_player);
    }

    // Add a yellow card (foul) to a player
    function addYellowCard(address _player) public onlyOwner {
        require(players[_player].exists, "Player not registered");
        players[_player].yellowCards += 1;
        emit YellowCardIssued(_player, players[_player].yellowCards);
    }

    // Add a red card (violation) to a player
    function addRedCard(address _player) public onlyOwner {
        require(players[_player].exists, "Player not registered");
        players[_player].redCards += 1;
        emit RedCardIssued(_player, players[_player].redCards);
    }

    // View player foul record
    function getPlayerRecord(address _player) public view returns (uint256, uint256) {
        require(players[_player].exists, "Player not registered");
        Player memory p = players[_player];
        return (p.yellowCards, p.redCards);
    }
}
