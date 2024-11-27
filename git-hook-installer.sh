#!/bin/sh

HOOKS_DIR=".git/hooks"
COMMIT_MSG_URL="https://raw.githubusercontent.com/creatim-slo/git-hooks/master/hooks/commit-msg"

if [ ! -d ".git" ]; then
    echo "Error: This script must be run inside a Git repository."
    exit 1
fi

if [ ! -d "$HOOKS_DIR" ]; then
    mkdir -p "$HOOKS_DIR"
fi

echo "Downloading Creatim Git hooks..."
if command -v curl > /dev/null 2>&1; then
    curl -s -o "$HOOKS_DIR/commit-msg" "$COMMIT_MSG_URL"
elif command -v wget > /dev/null 2>&1; then
    wget -q -O "$HOOKS_DIR/commit-msg" "$COMMIT_MSG_URL"
else
    echo "Error: Neither curl nor wget is installed. Please install one to proceed."
    exit 1
fi

if [ ! -f "$HOOKS_DIR/commit-msg" ]; then
    echo "Error: Failed to download the commit-msg hook from $COMMIT_MSG_URL."
    exit 1
fi

chmod +x "$HOOKS_DIR/commit-msg"

echo "Creatim Git hooks has been successfully installed."