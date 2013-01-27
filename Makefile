.PHONY: setup test

bin = node_modules/.bin

lib/an.hour.ago.js: src/an.hour.ago.coffee
	@cat $< | $(bin)/coffee --compile --stdio > $@

setup:
	@npm install

test:
	@$(bin)/mocha --compilers coffee:coffee-script
