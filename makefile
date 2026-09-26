PACKAGES := $(wildcard */)
STOW := stow --verbose --no-folding --target=$(HOME)

.PHONY: all delete

all:
	$(STOW) --restow $(PACKAGES)

delete:
	$(STOW) --delete $(PACKAGES)
