.DEFAULT_GOAL := build
.PHONY: format build test clean
SHELL := /bin/bash

# Formats both the cabal file and Haskell source files.
format:
	@echo "Formatting cabal file:"
	cabal-fmt --inplace $$(find . -name '*.cabal')

	@echo "Formatting Haskell source files:"
	ormolu --mode inplace $$(find src test -name '*.hs')

# Builds the project.
build: format
	cabal build

# Tests the project.
test: build
	cabal new-test --test-show-details=streaming

# Cleans the project.
clean:
	cabal clean