LANGUAGES := c cpp golang java objc rust 

all: $(LANGUAGES)

$(LANGUAGES):
	$(MAKE) -C $@ test

.PHONY: all $(LANGUAGES)
.DEFAULT_GOAL: all