abi:
	@mkdir abi
	@cp -R -f \
		../altestate-3/build/contracts/* \
		$(shell pwd)/abi

dev: abi
	@$(shell pwd)/node_modules/.bin/cross-env \
		WEB3=http://pub-node1.etherscan.io:8545\
		GAS_PRICE=1000000\
		DEBUG=error,warning,info,log,verb \
		$(shell pwd)/node_modules/.bin/nodemon $(shell pwd)/app.js $@ --exec $(shell pwd)/node_modules/.bin/babel-node

run: deps abi
	@$(shell pwd)/node_modules/.bin/cross-env \
		WEB3=http://pub-node1.etherscan.io:8545\
		GAS_PRICE=1000000\
		DEBUG=error,warning,info,log \
		$(shell pwd)/node_modules/.bin/babel-node $(shell pwd)/app.js $@

deps: 
	@npm install
