COFFEE = node_modules/.bin/coffee
MOCHA = node_modules/.bin/mocha --compilers coffee:coffee-script

JS_FILES = $(patsubst src/%.coffee,lib/%.js,$(shell find src -type f))


.PHONY: all
all: $(JS_FILES)

lib/%.js: src/%.coffee
	@cat $< | $(COFFEE) --compile --stdio > $@


.PHONY: setup
setup:
	@npm install


.PHONY: test
test:
	@$(MOCHA)
