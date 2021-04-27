import "hardhat-typechain";
import "hardhat-deploy";
import "hardhat-gas-reporter";
import "@nomiclabs/hardhat-waffle";
import "hardhat-abi-exporter";

module.exports = {
  // defaultNetwork: "hardhat",
  defaultNetwork: "testnet",
  networks: {
    hardhat: {
      // chain id 31337
      forking: {
        url: "https://bsc-dataseed.binance.org",
      },
      gas: 99999999,
      blockGasLimit: 99999999,
      accounts: {
        // deployer
        // 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
        // alice
        // 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
        // bob
        // 0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc
        // dev
        // 0x90f79bf6eb2c4f870365e785982e1f101e93b906
        mnemonic: "test test test test test test test test test test test junk",
        initialIndex: 0,
        count: 4,
        path: "m/44'/60'/0'/0",
        accountsBalance: "10000000000000000000000",
      },
    },
    testnet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      accounts: {
        mnemonic: "test test test test test test test test test test test junk",
        initialIndex: 0,
        count: 4,
        path: "m/44'/60'/0'/0",
        accountsBalance: "10000000000000000000000",
      },
    },
    mainnet: {
      url: "https://bsc-dataseed.binance.org",
      accounts: {
        mnemonic: "test test test test test test test test test test test junk",
        initialIndex: 0,
        count: 4,
        path: "m/44'/60'/0'/0",
        accountsBalance: "10000000000000000000000",
      },
    },
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
  },
  solidity: {
    version: "0.7.6",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
      evmVersion: "istanbul",
      outputSelection: {
        "*": {
          "": ["ast"],
          "*": [
            "evm.bytecode.object",
            "evm.deployedBytecode.object",
            "abi",
            "evm.bytecode.sourceMap",
            "evm.deployedBytecode.sourceMap",
            "metadata",
          ],
        },
      },
    },
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
  typechain: {
    outDir: "./typechain",
    target: "ethers-v5",
  },
  mocha: {
    timeout: 60000,
  },
  gasReporter: {
    currency: "BNB",
    gasPrice: 5,
  },
  abiExporter: {
    path: "./abis",
    clear: true,
    flat: true,
    spacing: 2,
  },
};
