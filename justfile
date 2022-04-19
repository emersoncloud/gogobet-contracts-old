deploy:
    RUST_BACKTRACE=full forge create --rpc-url http://localhost:9650/ext/bc/C/rpc src/Contract.sol:Contract -i

deploy-eth:
    RUST_BACKTRACE=full forge create --rpc-url https://eth-rinkeby.alchemyapi.io/v2/u4_QrkpLMT25csR4QhEgEcpx-pbWynQa src/Contract.sol:Contract -i

deploy-fuji:
    RUST_BACKTRACE=full forge create --rpc-url https://api.avax-test.network/ext/bc/C/rpc src/Contract.sol:Contract -i
