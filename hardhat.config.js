require("@nomiclabs/hardhat-waffle");
require("hardhat-abi-exporter");
require('dotenv').config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  abiExporter: {
    path: './data/abi',
    runOnCompile: true,
    clear: true,
    flat: true,
    only: [],
    spacing: 2,
    pretty: true,
  },

  defaultNetwork: "rinkeby",
  networks: {
    localhost: {
      url: "http://localhost:8545",
      accounts: ["0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"]
    },
    rinkeby: {
      url: "https://rinkeby.infura.io/v3/ed6dbf055b774e2b8fc1e6149e85b762",
      accounts: ['98a2e88d6eba9e63f83d96dcdc843b999c2e5a7b6b0414a9ea4b195bc752e984'],
      chainId: 4,
      symbol: "ETH"
    },
    gnosis: {
      url: "https://xdai-rpc.gateway.pokt.network",
      accounts: ['98a2e88d6eba9e63f83d96dcdc843b999c2e5a7b6b0414a9ea4b195bc752e984'],
      chainId: 100,
      symbol: "xDAI"
    }
  },
  // paths: {
  //   sources: "./contracts",
  //   tests: "./test",
  //   cache: "./cache",
  //   artifacts: "./artifacts"
  // },
  mocha: {
    timeout: 40000
  }
}