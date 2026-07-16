#!/bin/bash
set -e

TARBALL_URL="https://github.com/stad-nico/config/archive/refs/heads/main.tar.gz"
TARGET_DIR="$HOME/.dotfiles"

echo -e "\e[38;5;87m❖\e[0m \e[1m\e[38;5;252mBootstrapping Dotfiles Environment\e[0m"

if [ -d "$TARGET_DIR" ]; then
    echo -e "  \e[38;5;242m• Target directory exists. Updating via git...\e[0m"
    cd "$TARGET_DIR"
    if command -v git &> /dev/null; then
        git pull origin main || git pull origin master
    else
        echo -e "  \e[38;5;203m• Git not found. Skipping update. Run install script again after git is installed.\e[0m"
    fi
else
    echo -e "  \e[38;5;242m• Downloading and extracting repository to $TARGET_DIR...\e[0m"
    mkdir -p "$TARGET_DIR"
    if command -v curl &> /dev/null; then
        curl -fsSL "$TARBALL_URL" | tar -xz -C "$TARGET_DIR" --strip-components=1
    elif command -v wget &> /dev/null; then
        wget -qO- "$TARBALL_URL" | tar -xz -C "$TARGET_DIR" --strip-components=1
    else
        echo -e "  \e[38;5;203m✖ Error: Neither curl nor wget is installed.\e[0m"
        exit 1
    fi
    cd "$TARGET_DIR"
fi

echo -e "\n\e[38;5;63m➜\e[0m \e[1m\e[38;5;252mStarting Configuration\e[0m"
bash ./main.sh
