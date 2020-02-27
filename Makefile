NODE_MODULES?=node_modules
help:
	@echo ""
	@echo "Usage: make <target>"
	@echo ""
	@echo "available targets:"
	@echo "    tests ............. Run all tests."
	@echo "    test-js ........... Test javascript files for errors."
	@echo "    test-install ...... Test plugin installation Android."
	@echo ""
	@echo ""

test-js: jshint

jshint: check-jshint
	@echo "- JSHint"
	@${NODE_MODULES}/.bin/jshint --config .jshintrc scripts/*.js
	@echo "  Done"
	@echo ""

test-install:
	@./test/run.sh com.graybax.progplugintest progplugintest

tests: jshint test-install
	@echo 'ok'

check-jshint:
	@test -e "${NODE_MODULES}/.bin/jshint" || ( echo "${NODE_MODULES} not found."; echo 'Please install dependencies: npm install'; exit 1 )

clean:
	@find . -name '*~' -exec rm '{}' ';'
