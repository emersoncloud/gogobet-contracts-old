set positional-arguments
private_key := env_var('PRIVATE_KEY')

deploy_stub := "RUST_BACKTRACE=full forge create --private-key"

localhost := "--rpc-url http://localhost:9650/ext/bc/C/rpc"
rinkeby := "--rpc-url https://eth-rinkeby.alchemyapi.io/v2/u4_QrkpLMT25csR4QhEgEcpx-pbWynQa"
fuji := "--rpc-url https://api.avax-test.network/ext/bc/C/rpc"

bet_factory := "src/BetFactory.sol:BetFactory"

deploy-local:
    {{deploy_stub}} {{private_key}} {{localhost}} src/BetFactory.sol:BetFactory
 
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
