# 🟥 RedCard – Immutable Tracking of Player Fouls and Violations

> ⚽ A blockchain-based foul tracking system that ensures fairness, transparency, and immutability in sports recordkeeping.

![WhatsApp Image 2025-10-29 at 14 39 16_ba3a21f7](https://github.com/user-attachments/assets/e4dd35f2-75ff-4b76-af14-8364532acd18)



---

## 📘 Project Description

**RedCard** is a simple yet powerful **Solidity smart contract** designed to bring **accountability and transparency** to sports games.
It helps referees or league authorities **record and store player violations** (Yellow and Red Cards) permanently on the blockchain — ensuring **data integrity** and **tamper-proof match history**.

No more disputes or data manipulation — once recorded, a foul stays **immutable** forever!

---

## 💡 What It Does

* Keeps a **permanent record** of each player’s yellow and red cards.
* Allows only the **referee/admin (contract owner)** to record fouls.
* Stores player data **transparently on-chain**, visible to everyone.
* Enables **anyone to check** a player’s foul history anytime.

---

## ✨ Features

✅ **Immutable Data** – Once recorded, fouls cannot be changed or deleted.
✅ **Admin Control** – Only the contract owner can issue or register players.
✅ **Event Logging** – Every foul or registration emits a blockchain event.
✅ **Transparency** – Anyone can verify foul history directly from the blockchain.
✅ **Beginner-Friendly Solidity Code** – Great for learning mapping, structs, and modifiers.

---

## 🚀 Smart Contract

### **Contract Name:** `RedCard`

### **Language:** Solidity `^0.8.0`

### **License:** MIT

---

### 📄 Smart Contract Code

```solidity
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

```

---

## 🌍 Deployed Smart Contract

**Network:** XXX
**Contract Address:** XXX
**Explorer Link:** [View on Blockchain Explorer](XXX)

*(Replace XXX with your actual deployment details once live.)*

---

## 🧠 How It Works

1. **Deploy the contract** – You become the **admin/referee**.
2. **Register players** – Add players using their wallet addresses.
3. **Issue yellow/red cards** – Record fouls immutably on-chain.
4. **Query records** – Anyone can check a player’s foul count via `getPlayerRecord()`.

---

## 🛠️ Functions Overview

| Function                   | Description                              | Access     |
| -------------------------- | ---------------------------------------- | ---------- |
| `registerPlayer(address)`  | Registers a new player                   | Only Owner |
| `addYellowCard(address)`   | Issues a yellow card                     | Only Owner |
| `addRedCard(address)`      | Issues a red card                        | Only Owner |
| `getPlayerRecord(address)` | Fetches player’s yellow & red card count | Public     |

---

## 🧩 Example Workflow

1. **Register Player** → `registerPlayer(0xPlayerAddress)`
2. **Add Yellow Card** → `addYellowCard(0xPlayerAddress)`
3. **Add Red Card** → `addRedCard(0xPlayerAddress)`
4. **View Stats** → `getPlayerRecord(0xPlayerAddress)`

---

## 🧱 Tech Stack

* **Solidity** – Smart contract language
* **Ethereum / EVM-compatible chain** – For deployment
* **Remix IDE** – For quick development and testing
* **MetaMask** – For admin wallet interaction

---

## 🌱 Future Improvements

* Add **timestamps** and **foul history logs**
* Integrate **player names** and match IDs
* Build a **React-based frontend** to visualize live stats
* Mint **NFT badges** for fair play achievements

---

## 🤝 Contributing

Feel free to **fork** this repo, enhance the contract, and open a **pull request**.
Suggestions and feedback are always welcome! 💬

---

## 📜 License

This project is licensed under the **MIT License**.

---

### 💬 Author

Developed with ❤️ by **Jishnu**

> *“Bringing transparency to sports, one block at a time.”*
