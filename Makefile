#
# Makefile for HackerRank assignments
#
# At the moment this approach works only for interpretable languages (such as Haskell, Swift, Python, Ruby)
# In other words only for languages that come with interpreter
# It doesn't work for languages that require complication (C, C++, etc.)
# But can be further exended to support compilation as well

# Actual directory of this Makefile, not where it is called form
SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

# Compile (YES) vs interpret (NO)
COMPILE = NO

# Temporary directory
TMP_DIR := $(shell mktemp -dt "XXXXXXXX")

# Build directory
BUILD_DIR := $(CURDIR)/build

# OSX SDK
OSX_SDK := $(shell xcrun --show-sdk-path --sdk macosx)

# Swift executables
# TODO: 10.9 use 'xcrun swift(c)', since 10.10 can use just 'swift(c)'
XCODE = Xcode
DEVELOPER_DIR = /Applications/$(XCODE).app/Contents/Developer
SWIFT = swift
SWIFTC = swiftc
SWIFT_STDIO = StdIO
SWIFT_STDIO_LIB_NAME = lib$(SWIFT_STDIO).dylib



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
run-tc = cat $(call tc-path,$(1),$(2),$(3)) | $(4) $@

# Enable phony targets
.PHONY:

ifeq ($(COMPILE), NO)	# Interpret

# Haskell
%.hs: .PHONY
	@$(call run-tc,$(TC),hs,$@,runghc)

# Swift
%.swift: .PHONY
	@$(call run-tc,$(TC),swift,$@,$(SWIFT))

# Ruby
%.rb: .PHONY
	@$(call run-tc,$(TC),rb,$@,ruby)

else	# Compile and run

# Haskell
%.hs: .PHONY
	@echo "Compilation is not supported for Haskell yet."

# Swift compile and run
%.swift: .PHONY
	@mkdir -p $(BUILD_DIR)

	@# build stdio module
	@$(SWIFTC) \
		-sdk $(OSX_SDK) \
		-emit-library \
		-o $(BUILD_DIR)/$(SWIFT_STDIO_LIB_NAME) \
		-emit-module $(SELF_DIR)/$(SWIFT_STDIO).swift \
		-module-name $(SWIFT_STDIO)

	@# run linking against stdio module
	@cat $(call tc-path,$(TC),swift,$@) \
		| $(SWIFT) \
			-sdk $(OSX_SDK) \
			-l$(BUILD_DIR)/$(SWIFT_STDIO_LIB_NAME) \
			-I $(BUILD_DIR) -module-link-name $(SWIFT_STDIO) \
			-D CLI_BUILD \
			$@

# Ruby
%.rb: .PHONY
	@echo "Compilation is not supported for Ruby (yet?)."

endif	# Compile vs Run

# Prepare for submission
%.swift-prep:
	@cat $(SELF_DIR)/$(SWIFT_STDIO).swift $(patsubst %-prep,%,$@) | grep -v -E "#if|#endif" | pbcopy
	@echo "Solution is copied to clipboard, use ⌘ + V to paste it to HackerRank."

# Clean
clean:
	@rm -rf $(BUILD_DIR)

# Help
help:
	@echo "Run test case for given source file."
	@echo "Targets:"
	@echo "\t- Haskell:\t.hs files."
	@echo "\t- Swift:\t.swift files."
	@echo "\t- Ruby:\t\t.rb files."
	@echo "Variables:"
	@echo "\t- Use TC variable to specify test case number."
	@echo "\t\tmake -f /path/to/Makefile assignment.swift TC=1"
	@echo "\t- Use COMPILE variable to compile source code before running."
	@echo "\t\tmake -f /path/to/Makefile assignment.swift COMPILE=YES"
