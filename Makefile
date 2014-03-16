COFFEE = node_modules/.bin/coffee
MOCHA = node_modules/.bin/mocha --compilers coffee:coffee-script
SEMVER = node_modules/.bin/semver

JS_FILES = $(patsubst src/%.coffee,lib/%.js,$(shell find src -type f))


.PHONY: all
all: $(JS_FILES)

lib/%.js: src/%.coffee
	$(COFFEE) --compile --output $(@D) -- $<


.PHONY: clean
clean:
	rm -f -- $(JS_FILES)


.PHONY: release-patch release-minor release-major
VERSION = $(shell node -p 'require("./package.json").version')
release-patch: NEXT_VERSION = $(shell $(SEMVER) -i patch $(VERSION))
release-minor: NEXT_VERSION = $(shell $(SEMVER) -i minor $(VERSION))
release-major: NEXT_VERSION = $(shell $(SEMVER) -i major $(VERSION))

release-patch release-minor release-major:
	@printf 'Current version is $(VERSION). This will publish version $(NEXT_VERSION). Press [enter] to continue.' >&2
	@read
	node -e '\
		var o = require("./package.json"); o.version = "$(NEXT_VERSION)"; \
		require("fs").writeFileSync("./package.json", JSON.stringify(o, null, 2) + "\n")'
	git commit --message '$(NEXT_VERSION)' -- package.json
	git tag --annotate '$(NEXT_VERSION)' --message '$(NEXT_VERSION)'
	git push origin refs/heads/master 'refs/tags/$(NEXT_VERSION)'
	npm publish


.PHONY: setup
setup:
	npm install


.PHONY: test
test:
	$(MOCHA)
