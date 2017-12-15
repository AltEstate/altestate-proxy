CONTRACTS:=		"../altestate/build/contracts"
NODE:=				"http://localhost:8545"
FROM:=				"0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1"
PRIVATE_KEY:=	"4f3edf983ac636a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d"
GAS_PRICE:=		"1000000"
GAS_LIMIT:=		"5000000"

.PHONY: abi

variables: 
	@echo Contracts Path:		$(value CONTRACTS)
	@echo Node: 						$(value NODE)
	@echo From:							$(value FROM)
	@echo Private:					$(value PRIVATE_KEY)
	@echo Gas Price:				$(value GAS_PRICE)
	@echo Gas Limit:				$(value GAS_LIMIT)

abi:
	@rm -rf $(shell pwd)/abi
	@mkdir $(shell pwd)/abi
	@cp -R -f \
		$(shell pwd)/$(value CONTRACTS)/* \
		$(shell pwd)/abi

run: variables abi install
	@$(shell pwd)/node_modules/.bin/cross-env\
		WEB3=$(value NODE)\
		PRIVATE_KEY=$(value PRIVATE_KEY)\
		FROM=$(value FROM)\
		GAS_PRICE=1000000\
		DEBUG=error,warning,info,log,verb\
		$(shell pwd)/node_modules/.bin/nodemon $(shell pwd)/app.js $@ --exec $(shell pwd)/node_modules/.bin/babel-node

install:
	@npm install
