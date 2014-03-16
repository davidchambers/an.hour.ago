bin = node_modules/.bin


lib/an.hour.ago.js: src/an.hour.ago.coffee
	@cat $< | $(bin)/coffee --compile --stdio > $@


.PHONY: setup
setup:
	@npm install


.PHONY: test
test:
	@$(bin)/mocha --compilers coffee:coffee-script
