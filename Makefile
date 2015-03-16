#
# Makefile for HackerRank assignments
#
# At the moment this approach works only for interpretable languages (such as Haskell, Swift, Python, Ruby)
# In other words only for languages that come with interpreter
# It doesn't work for languages that require complication (C, C++, etc.)
# But can be further exended to support compilation as well

# Actual directory of this Makefile, not where it is called form
SELF_DIR = $(dir $(lastword $(MAKEFILE_LIST)))

# Temporary directory
TMP_DIR := $(shell mktemp -dt "XXXXXXXX")

# OSX SDK
OSX_SDK := $(shell xcrun --show-sdk-path --sdk macosx)

# Swift executables
# 10.9 use 'xcrun swift(c)', since 10.10 can use just 'swift(c)'
SWIFT = swift
SWIFTC = swiftc
SWIFT_STDIO = StdIO
# libStdIO.dylib
SWIFT_STDIO_LIB_NAME = lib$(SWIFT_STDIO).dylib

# Recommended name for alias
ALIAS=hrrun
# Test cases directory
TC_DIR = tc
# Test case number
TC = 0

# Get the path to test case file
# usage: $(call tc-path,TC,EXT,FILE)
# where:
# TC - test case number
# EXT - file extension (e.g. hs, swift, rb, py, etc.)
# FILE - name of the source file (use $@ to pass it from recipe)
tc-path = $(TC_DIR)/$(patsubst %.$(2),%-tc$(1).txt,$(3))

# Run test case
# usage: $(call run-tc,TC,EXT,FILE,CMD)
# where:
# TC - test case number
# EXT - file extension (e.g. hs, swift, rb, py, etc.)
# FILE - name of the source file (use $@ to pass it from recipe)
# CMD - interpreter command to run the source file (e.g. runghc, xcrun swift, etc.)
run-tc = export TC_FILE=$(TC_DIR)/$(patsubst %.$(2),%-tc$(1).txt,$(3)); \
					cat $${TC_FILE} | $(4) $@

# Enable phony targets
.PHONY:

# Haskell
%.hs: .PHONY
	@$(call run-tc,$(TC),hs,$@,runghc)

# Swift (run as is)
# %.swift: .PHONY
	# @$(call run-tc,$(TC),swift,$@,$(SWIFT))

# swiftc -emit-library -module-name StdIO -emit-module ../../StdIO.swift -sdk  $(xcrun --show-sdk-path --sdk macosx)

%.swift: .PHONY
	@# build stdio module
	@$(SWIFTC) -sdk $(OSX_SDK) \
		-emit-library \
		-o $(TMP_DIR)/$(SWIFT_STDIO_LIB_NAME) \
		-emit-module $(SELF_DIR)/$(SWIFT_STDIO).swift \
		-module-name $(SWIFT_STDIO)

	@# run linking against stdio module
	@#ls $(TMP_DIR)
	@cat $(call tc-path,$(TC),swift,$@) \
		| $(SWIFT) \
			-l$(TMP_DIR)/$(SWIFT_STDIO_LIB_NAME) \
			-I $(TMP_DIR) -module-link-name $(SWIFT_STDIO) \
			-sdk $(OSX_SDK) \
			-D CLI \
			$@


help:
	@echo "Run test case $(TC) for given source file."
	@echo "Use TC variable to specify test case number."
	@echo "Examples:"
	@echo "- Haskell with default test case 0:"
	@echo "\t$(ALIAS) solve-me-first.hs"
	@echo "- Swift with test case 1:"
	@echo "\t$(ALIAS) solve-me-first.swift TC=1"
