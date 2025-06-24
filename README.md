
# Simple Chainlink Lottery on Sepolia

This is a simple decentralized lottery smart contract using Chainlink VRF v2.5 built for the Sepolia testnet.

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
