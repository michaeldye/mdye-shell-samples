SHELL := /usr/bin/env TZ=UTC bash

SCRIPTS := $(shell find $(CURDIR) -iname "*.bash") # including tests and common, for linting

ifndef verbose
.SILENT:
endif

all: inspect

inspect: check lint

check: test

lint:
	@echo "++ $@"
	-shellcheck -e SC1091 -s bash -S style $(SCRIPTS)

clean:
	@echo "++ $@"
	rm -Rf $(shell find $(CURDIR) -iname "*.workdir" -type d)

pristine: clean
	@echo "++ $@"
	git reset --hard HEAD
	git clean -fdx

$(TEST_LOG_DIR):
	mkdir -p $@

test:
	@echo "++ $@"
	util/execute-tests.bash $(CURDIR)/tests

.PHONY: all check inspect lint test test-log