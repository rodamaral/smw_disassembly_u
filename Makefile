EXPECTED_HASH := 0838e531fe22c077528febe14cb3ff7c492f1f5fa8de354192bdff7137c27f5b

.PHONY: all clean debug run debug_fresh check_hash

all:
	asar --symbols=wla main.asm SMW.sfc
	$(MAKE) check_hash

check_hash:
	@hash=$$(sha256sum SMW.sfc | cut -d' ' -f1); \
	if [ "$$hash" != "$(EXPECTED_HASH)" ]; then \
		echo "🚨 Wrong hash"; \
		echo "Expected: $(EXPECTED_HASH)"; \
		echo "Obtained:   $$hash"; \
		exit 1; \
	else \
		echo "✓ SHA-256 OK: $$hash"; \
	fi

clean:
	rm -f SMW.sfc

debug:
	asar debug.asm SMW.sfc
	$(MAKE) check_hash

run:
	$(MAKE) all
	./SMW.sfc

debug_fresh:
	asar main.asm SMW.sfc
	asar debug.asm SMW.sfc
	$(MAKE) check_hash
