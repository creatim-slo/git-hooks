#!/bin/sh

SCRIPT_URL="https://raw.githubusercontent.com/creatim-slo/git-hooks/master/git-hook-installer.sh"
TEMP_SCRIPT="git-hook-installer.sh"

# define red color for error messages
RED="\033[0;31m"
RESET="\033[0m"

echo "Downloading Git hooks installer from $SCRIPT_URL..."

# check for curl or wget
if command -v curl > /dev/null 2>&1; then
    curl -s -o "$TEMP_SCRIPT" "$SCRIPT_URL"
elif command -v wget > /dev/null 2>&1; then
    wget -q -O "$TEMP_SCRIPT" "$SCRIPT_URL"
else
    echo -e "${RED}Error: Neither curl nor wget is installed. Please install one to proceed.${RESET}"
    exit 1
fi

# ensure the script was downloaded successfully
if [ ! -f "$TEMP_SCRIPT" ]; then
    echo -e "${RED}Error: Failed to download the script from $SCRIPT_URL${RESET}"
    exit 1
fi

# make the downloaded script executable
chmod +x "$TEMP_SCRIPT"

echo "Running the downloaded script..."
OUTPUT=$(sh "$TEMP_SCRIPT")
EXIT_CODE=$?

# check if the script executed successfully
if [ $EXIT_CODE -ne 0 ]; then
    echo "${RED}Error: The script failed to execute successfully.${RESET}"
    echo "$OUTPUT"
    rm "$TEMP_SCRIPT"
    exit 1
fi

# clean up
rm "$TEMP_SCRIPT"

echo "Git hooks installed successfully!"
