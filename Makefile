# Makefile for TUI and log_generator
# Compatible with both macOS and Linux (Ubuntu)

CC = gcc
CFLAGS = -Wall -Wextra -O2

# Libraries must come AFTER source files for Linux compatibility
LIBS = -lcurl -ljansson -lcrypto

# Detect OS for library paths
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
    # macOS with Homebrew
    INCLUDE_PATH = -I/opt/homebrew/include
    LIB_PATH = -L/opt/homebrew/lib
else
    # Linux
    INCLUDE_PATH =
    LIB_PATH =
endif

# Targets
TUI = tui

# Source files
SRC = tui.c
OBJ = $(SRC:.c=.o)

# Files
# PRIVATE_KEY = $(TUI).key.pem
# PUBLIC_KEY = $(TUI).pub.pem

.PHONY: all clean help

all: $(TUI)

$(TUI): $(OBJ)
	$(CC) $(CFLAGS) $(INCLUDE_PATH) -o $(TUI) $(OBJ) $(LIB_PATH) $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDE_PATH) -c $< -o $@

clean:
	rm -f $(TUI) $(OBJ) $(PRIVATE_KEY) $(PUBLIC_KEY)


help:
	@echo "Available targets:"
	@echo "  make tui               - Build only tui"
	@echo "  make clean             - Remove compiled binaries and test logs"
