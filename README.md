
# Simple Chainlink Lottery on Sepolia

This is a simple decentralized lottery smart contract using Chainlink VRF v2.5 built for the Sepolia testnet.

![Solidity Version](https://img.shields.io/badge/solidity-0.8.26-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![GitHub repo size](https://img.shields.io/github/repo-size/DCVglobalnetwork/simple-chainlink-lottery)

## 🧰 Requirements

- MetaMask
- Remix IDE
- Sepolia ETH from faucet: https://sepoliafaucet.com
- Sepolia LINK from faucet: https://faucets.chain.link/sepolia
- Chainlink VRF v2.5 Subscription: https://vrf.chain.link/sepolia

## 🚀 How to Use

### 1. Compile and Deploy in Remix

- Open [Remix](https://remix.ethereum.org)
- Paste `Lottery.sol` code into a new file
- Compile using Solidity version `0.8.26`
- Deploy using Injected Web3 (MetaMask)
- Pass your **subscriptionId** as constructor argument

### 2. Add the Contract as a Consumer

- Go to: https://vrf.chain.link/sepolia
- Open your subscription
- Click "Add Consumer"
- Paste your deployed contract address

### 3. Interact

- `enter()` — Add player to the lottery
- `requestWinner()` — Request random number from Chainlink (triggers winner)
- `getPlayers()` — View current participants
- `winner` — Public variable showing current winner
- `resetLottery()` — Reset state for next round

### ✅ Done!

You now have a simple working lottery on Sepolia testnet.

---

## 📚 Learn More

You can read a detailed article explaining how to build and deploy this decentralized lottery on Remix here:

[How to build a decentralized lottery in 48 hours using Chainlink VRF and Automation](https://medium.com/block-magnates/how-to-built-a-decentralized-lottery-in-48-hours-using-chainlink-vrf-and-automation-fe1f0a6a717f)

