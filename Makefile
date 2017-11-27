run: deps
	@$(shell pwd)/node_modules/.bin/cross-env \
		PRIVATE_KEY=1\
		FROM_ADDRESS=2\
		WEB3=3\
		GAS_LIMIT=4\
		GAS_PRICE=5\
		DEBUG=error,warning,info,log \
		$(shell pwd)/node_modules/.bin/babel-node $(shell pwd)/app.js $@

deps: 
	@npm install
