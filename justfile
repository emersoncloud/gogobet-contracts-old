set positional-arguments
# private_key := env_var('PRIVATE_KEY')

# deploy_stub := "RUST_BACKTRACE=full forge create --private-key"
deploy_stub := "RUST_BACKTRACE=full forge create -i"

localhost := "--rpc-url http://localhost:9650/ext/bc/C/rpc"
rinkeby := "--rpc-url https://eth-rinkeby.alchemyapi.io/v2/u4_QrkpLMT25csR4QhEgEcpx-pbWynQa"
fuji := "--rpc-url https://api.avax-test.network/ext/bc/C/rpc"

bet_factory := "src/BetFactory.sol:BetFactory"

# deploy-local:
#     {{deploy_stub}} {{private_key}} {{localhost}} src/BetFactory.sol:BetFactory
 
deploy *args='': 
    #!/usr/bin/env sh
    if [ "$1" = "local" ]; then
        {{deploy_stub}} $2 {{localhost}} {{bet_factory}}
    elif [ "$1" == "rinkeby" ]; then
        {{deploy_stub}} $2 {{rinkeby}} {{bet_factory}}
    elif [ "$1" == "fuji" ]; then
        {{deploy_stub}} $2 {{fuji}} {{bet_factory}}
    else 
        echo "env $1 not recognized"
    fi

build:
    forge build

test: 
    forge test

compile:
    npx hardhat compile

hh *args='': 
    #!/usr/bin/env sh
    if [ "$1" == "hh" ]; then 
        npx hardhat run scripts/script.ts --network hardhat
    elif [ "$1" == "local" ]; then
        npx hardhat run scripts/script.ts --network local
    elif [ "$1" == "fuji" ]; then
        npx hardhat run scripts/script.ts --network fuji
    elif [ "$1" == "mainnet" ]; then
        npx hardhat run scripts/script.ts --network mainnet
    else 
        echo "env $1 not recognized"
    fi

test_bet: 
    npx hardhat run scripts/test_emit.ts

test_12: 
    npx hardhat run scripts/test_12.ts

test_hash: 
    npx hardhat run scripts/sha3.ts