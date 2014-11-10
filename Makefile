COFFEE = node_modules/.bin/coffee
ISTANBUL = node_modules/.bin/istanbul
XYZ = node_modules/.bin/xyz --repo git@github.com:davidchambers/an.hour.ago.git --script scripts/prepublish

SRC = $(shell find src -name '*.coffee')
LIB = $(patsubst src/%.coffee,lib/%.js,$(SRC))


.PHONY: all
all: $(LIB)

lib/%.js: src/%.coffee
	$(COFFEE) --compile --output $(@D) -- $<


.PHONY: clean
clean:
	rm -f -- $(LIB)


.PHONY: release-major release-minor release-patch
release-major release-minor release-patch:
	@$(XYZ) --increment $(@:release-%=%)


.PHONY: setup
setup:
	npm install
	make clean
	git update-index --assume-unchanged -- $(LIB)


.PHONY: test
test: all
	$(ISTANBUL) cover node_modules/.bin/_mocha -- --compilers coffee:coffee-script/register
