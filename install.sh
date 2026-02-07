#!/bin/bash
#
# VSCode-based IDE settings sync script for macOS/Linux
# Usage: ./install.sh [--cursor] [--vscode] [--antigravity] [--all] [--extensions-only] [--settings-only]
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Flags
INSTALL_CURSOR=false
INSTALL_VSCODE=false
INSTALL_ANTIGRAVITY=false
EXTENSIONS_ONLY=false
SETTINGS_ONLY=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --cursor) INSTALL_CURSOR=true; shift ;;
        --vscode) INSTALL_VSCODE=true; shift ;;
        --antigravity) INSTALL_ANTIGRAVITY=true; shift ;;
        --all) INSTALL_CURSOR=true; INSTALL_VSCODE=true; INSTALL_ANTIGRAVITY=true; shift ;;
        --extensions-only) EXTENSIONS_ONLY=true; shift ;;
        --settings-only) SETTINGS_ONLY=true; shift ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

# Default to all if none specified
if [[ "$INSTALL_CURSOR" == "false" && "$INSTALL_VSCODE" == "false" && "$INSTALL_ANTIGRAVITY" == "false" ]]; then
    INSTALL_CURSOR=true
    INSTALL_VSCODE=true
    INSTALL_ANTIGRAVITY=true
fi

# Detect OS
OS="$(uname -s)"
case "$OS" in
    Darwin) OS_TYPE="mac" ;;
    Linux) OS_TYPE="linux" ;;
    MINGW*|MSYS*|CYGWIN*) OS_TYPE="windows" ;;
    *) echo "Unsupported OS: $OS"; exit 1 ;;
esac

# IDE paths configuration
get_settings_path() {
    local ide=$1
    case "$OS_TYPE" in
        mac)
            case "$ide" in
                cursor) echo "$HOME/Library/Application Support/Cursor/User" ;;
                vscode) echo "$HOME/Library/Application Support/Code/User" ;;
                antigravity) echo "$HOME/Library/Application Support/Antigravity/User" ;;
            esac
            ;;
        linux)
            case "$ide" in
                cursor) echo "$HOME/.config/Cursor/User" ;;
                vscode) echo "$HOME/.config/Code/User" ;;
                antigravity) echo "$HOME/.config/Antigravity/User" ;;
            esac
            ;;
        windows)
            case "$ide" in
                cursor) echo "$APPDATA/Cursor/User" ;;
                vscode) echo "$APPDATA/Code/User" ;;
                antigravity) echo "$APPDATA/Antigravity/User" ;;
            esac
            ;;
    esac
}

get_cli() {
    local ide=$1
    case "$ide" in
        cursor)
            if command -v cursor &> /dev/null; then
                echo "cursor"
            elif [[ "$OS_TYPE" == "mac" ]] && [[ -f "/Applications/Cursor.app/Contents/Resources/app/bin/cursor" ]]; then
                echo "/Applications/Cursor.app/Contents/Resources/app/bin/cursor"
            fi
            ;;
        vscode)
            if command -v code &> /dev/null; then
                echo "code"
            elif [[ "$OS_TYPE" == "mac" ]] && [[ -f "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]]; then
                echo "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
            fi
            ;;
        antigravity)
            if command -v antigravity &> /dev/null; then
                echo "antigravity"
            elif [[ "$OS_TYPE" == "mac" ]] && [[ -f "/Applications/Antigravity.app/Contents/Resources/app/bin/antigravity" ]]; then
                echo "/Applications/Antigravity.app/Contents/Resources/app/bin/antigravity"
            fi
            ;;
    esac
}

install_settings() {
    local ide=$1
    local settings_path=$(get_settings_path "$ide")

    echo -e "${CYAN}[$ide] Installing settings...${NC}"

    # Create directory if not exists
    mkdir -p "$settings_path"
    mkdir -p "$settings_path/snippets"

    # Copy settings.json
    if [[ -f "$SCRIPT_DIR/settings.json" ]]; then
        cp "$SCRIPT_DIR/settings.json" "$settings_path/settings.json"
        echo -e "  ${GREEN}- settings.json copied${NC}"
    fi

    # Copy keybindings.json
    if [[ -f "$SCRIPT_DIR/keybindings.json" ]]; then
        cp "$SCRIPT_DIR/keybindings.json" "$settings_path/keybindings.json"
        echo -e "  ${GREEN}- keybindings.json copied${NC}"
    fi

    # Copy snippets
    if [[ -d "$SCRIPT_DIR/snippets" ]] && [[ -n "$(ls -A "$SCRIPT_DIR/snippets" 2>/dev/null)" ]]; then
        cp -r "$SCRIPT_DIR/snippets/"* "$settings_path/snippets/"
        echo -e "  ${GREEN}- snippets copied${NC}"
    fi
}

install_extensions() {
    local ide=$1
    local cli=$(get_cli "$ide")

    if [[ -z "$cli" ]]; then
        echo -e "${YELLOW}[$ide] CLI not found, skipping extensions${NC}"
        return
    fi

    echo -e "${CYAN}[$ide] Installing extensions...${NC}"

    while IFS= read -r ext || [[ -n "$ext" ]]; do
        # Skip comments and empty lines
        [[ "$ext" =~ ^#.*$ ]] && continue
        [[ -z "${ext// }" ]] && continue

        ext=$(echo "$ext" | tr -d '[:space:]')
        echo -e "  ${YELLOW}- Installing $ext...${NC}"
        "$cli" --install-extension "$ext" --force 2>/dev/null || true
    done < "$SCRIPT_DIR/extensions.txt"

    echo -e "${GREEN}[$ide] Extensions installed${NC}"
}

process_ide() {
    local ide=$1

    if [[ "$EXTENSIONS_ONLY" != "true" ]]; then
        install_settings "$ide"
    fi

    if [[ "$SETTINGS_ONLY" != "true" ]]; then
        install_extensions "$ide"
    fi
}

# Main
echo -e "${MAGENTA}=== VSCode Profiles Sync ===${NC}"
echo -e "OS: $OS_TYPE"

if [[ "$INSTALL_CURSOR" == "true" ]]; then
    process_ide "cursor"
fi

if [[ "$INSTALL_VSCODE" == "true" ]]; then
    process_ide "vscode"
fi

if [[ "$INSTALL_ANTIGRAVITY" == "true" ]]; then
    process_ide "antigravity"
fi

echo -e "\n${MAGENTA}=== Sync Complete ===${NC}"
echo -e "${YELLOW}Restart your IDE(s) to apply changes.${NC}"
