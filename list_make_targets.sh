#!/bin/bash

# Check if make is installed
if ! command -v make &>/dev/null; then
    echo "Error: 'make' is not installed."
    echo "Please install it first:"
    echo "  - For Ubuntu/Debian: sudo apt install make"
    echo "  - For macOS: brew install make"
    echo "  - For RHEL/CentOS/Fedora: sudo dnf install make"
    exit 1
fi

echo ''
echo 'Run `make [target]` to install.'
echo 'Available targets are:'
echo '~/[path to file under files/]'

# Cross-platform grep solution
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS uses BSD grep which doesn't support -P (Perl regex)
    cat Makefile | grep -o '^\w*:' | sed 's/:$//'
else
    # Linux and others use GNU grep with Perl regex support
    cat Makefile | grep -oP '^\w*:' | sed 's/:$//'
fi
