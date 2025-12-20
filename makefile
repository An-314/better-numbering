BUILD_DIR := builds

MAIN_SRC := demo.typ
MAIN_PDF := $(BUILD_DIR)/demo.pdf

.PHONY: all clean

all: $(MAIN_PDF) $(HW_PDF)
	@echo "Build complete."

$(MAIN_PDF): $(MAIN_SRC)
	mkdir -p $(dir $@)
	typst compile $< $@

clean:
	rm -rf $(BUILD_DIR)