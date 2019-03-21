const HDWalletProvider = require('truffle-hdwallet-provider');
const fs = require('fs');

let secrets;
let mnemonic = '';

if (fs.existsSync('secrets.json')) {
  secrets = JSON.parse(fs.readFileSync('secrets.json', 'utf8'));
  mnemonic = secrets.mnemonic;
}

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    },
    docker: {
      host: "eth-node",
      port: 8545,
      network_id: "*",
      gas: 4600000,
      gasPrice: 21000000000
    },
    k8sdev: {
      provider: new HDWalletProvider(mnemonic, 'http://35.231.60.112:8545'),
      port: 8545,
      network_id: '224895',
      gas: 4600000
    },
    rinkeby: {
      provider: new HDWalletProvider(mnemonic, 'https://rinkeby.infura.io'),
      network_id: '4',
      gas: 4500000,
      gasPrice: 21000000000
    }
  },
  compilers: {
   solc: {
     version: "0.4.24"  // ex:  "0.4.20". (Default: Truffle's installed solc)
   }
 },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
}