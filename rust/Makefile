TASKS ?= $(patsubst %/,%,$(dir $(wildcard */main.rs))) # https://stackoverflow.com/a/33126533/902217

BINDIR := bin
TIMEOUT_CMD := timeout
TIMOEUT_VALUE := 5s

$(BINDIR)/%: %/main.rs $(BINDIR)
	rustc $< -o $@

$(BINDIR):
	mkdir -p $(BINDIR)

build: $(patsubst %,$(BINDIR)/%,$(TASKS))

define TEST_TARGETS

$(BINDIR)/$(1)_output%.txt: $(1)/test/input%.txt build
	@start_time=$$$$(date +%s); \
	OUTPUT_PATH=$$@ $(TIMEOUT_CMD) $(TIMOEUT_VALUE) $(BINDIR)/$(1) < $$< > $$@; \
	test_exitcode=$$$${?}; \
	end_time=$$$$(date +%s); \
	diff_time=$$$$(expr $$$$end_time - $$$$start_time); \
	if [ $$$${test_exitcode} == 124 ]; then \
		test_status="timeout"; \
	else \
		if diff $(1)/test/output$$(*).txt $$@ > /dev/null; then \
			test_status="success"; \
		else \
			test_status="failure"; \
		fi \
	fi; \
	echo "[$$$${test_status}] $(1) / $$* / $$$${diff_time} sec."

endef

$(foreach t,$(TASKS),$(eval $(call TEST_TARGETS,$t)))

REF_OUTPUTS := $(wildcard $(patsubst %,%/test/output*.txt,$(TASKS)))
REAL_OUTPUTS := $(patsubst %,$(BINDIR)/%,$(subst /test/,_,$(REF_OUTPUTS)))

test: $(REAL_OUTPUTS)

clean: $(BINDIR)
	rm -rf $(BINDIR)

.PHONY: build test clean
.DEFAULT_GOAL := build