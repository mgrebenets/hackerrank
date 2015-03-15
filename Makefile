#
# Makefile for HackerRank assignments
#
# At the moment this approach works only for interpretable languages (such as Haskell, Swift, Python, Ruby)
# In other words only for languages that come with interpreter
# It doesn't work for languages that require complication (C, C++, etc.)
# But can be further exended to support compilation as well

# Recommended name for alias
ALIAS=hrrun
# Test cases directory
TC_DIR = tc
# Test case number
TC = 0

# Run test case
# usage: $(call run-tc,TC,EXT,FILE,CMD)
# where
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

# Swift
%.swift: .PHONY
	@$(call run-tc,$(TC),swift,$@,xcrun swift)

help:
	@echo "Run test case $(TC) for given source file."
	@echo "Use TC variable to specify test case number."
	@echo "Examples:"
	@echo "- Haskell with default test case 0:"
	@echo "\t$(ALIAS) solve-me-first.hs"
	@echo "- Swift with test case 1:"
	@echo "\t$(ALIAS) solve-me-first.swift TC=1"
