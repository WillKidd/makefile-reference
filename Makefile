# Define Reusable Variables
CC = gcc
CFLAGS = -Wall -g
SRC_DIR = src
BUILD_DIR = build
TARGET = $(BUILD_DIR)/app

# Collect all .c files SRC_DIR
SOURCES = $(wildcard $(SRC_DIR)/*.c)
# Extrapolate *.o filenames before they are created
OBJECTS = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SOURCES))

# Phony targets: Targets that are not files, used for commands
.PHONY: all clean help

# Default target: The first target is the default ("all" here)
all: $(TARGET)
	@echo "Build complete!"

# Build final executable
$(TARGET): $(OBJECTS) | $(BUILD_DIR)
	@echo "Linking objects to create $(TARGET)"
	$(CC) $(CFLAGS) -o $@ $^

# Pattern rule: How to convert .c to .o
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "Compiling $< into $@"
	$(CC) $(CFLAGS) -c $< -o $@

# Create the build directory if it doesn't exist
$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Clean target: Remove generated files
clean:
	@echo "Cleaning up..."
	rm -rf $(BUILD_DIR)

# Help target: Provide information on available targets
help:
	@echo "Available targets:"
	@echo "  all     - Build the project"
	@echo "  clean   - Remove all generated files"
	@echo "  help    - Show this help message"

# Example of a dependency target
# Say we have a config file that affects the build
config.h: generate-config
	@echo "Generating config.h"
	touch $@

generate-config:
	@echo "Simulating config generation..."

# Notes:
# 1. $@ represents the target name.
# 2. $< represents the first prerequisite (usually the source file).
# 3. $^ represents all prerequisites.
# 4. You can chain commands with | as prerequisites, ensuring they run before the target.