
#
# Binaries
#

BIN := ./node_modules/.bin

#
# Variables
#

DIST = dist

#
# Tasks
#

build: node_modules index.js
	@mkdir -p $(DIST)
	@$(BIN)/browserify index.js --standalone fitvids -o $(DIST)/fitvids.js
	@$(BIN)/uglifyjs $(DIST)/fitvids.js -o $(DIST)/fitvids.min.js

node_modules: package.json
	@npm install
	@touch node_modules

test:
	@$(BIN)/hihat test.js

lint:
	@$(BIN)/xo index.js test.js

size: build
	@cat $(DIST)/fitvids.js | gzip -9 | wc -c
