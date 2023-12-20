.DEFAULT_GOAL := build
.PHONY: format build test clean

# Formats both the cabal file and Haskell source files.
format:
	@echo "Formatting squizz.cabal..."
	cabal-fmt --inplace squizz.cabal

	@echo "Formatting Haskell source files..."
	find . -name 'src/*.hs' -exec ormolu --mode inplace {} \;
	find . -name 'test/*.hs' -exec ormolu --mode inplace {} \;

# Builds the project.
build: format
	cabal build

# Tests the project.
test: build
	cabal new-test --test-show-details=streaming

# Cleans the project.
clean:
	cabal clean