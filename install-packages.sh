#!/bin/bash
set -e
source ./variables.sh

export DEBIAN_FRONTEND=noninteractive
PACKAGES="stow curl git gh"

if command -v apt-get &> /dev/null; then
    echo -e "${PREFIX} ${C_TEXT}Updating APT package sources...${RESET}"
    execute "sudo apt-get update -y -qq"

    # Add GitHub CLI repo for apt if gh isn't available by default
    if ! apt-cache search "^gh$" | grep -q "gh"; then
        echo -e "${PREFIX} ${C_TEXT}Adding GitHub CLI repository...${RESET}"
        execute "curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg 2>/dev/null"
        execute "sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg"
        execute "echo \"deb [arch=\$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main\" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null"
        execute "sudo apt-get update -y -qq"
    fi

    echo -e "${PREFIX} ${C_TEXT}Upgrading existing packages...${RESET}"
    execute "sudo apt-get upgrade -y -qq"

    echo -e "${PREFIX} ${C_TEXT}Installing core packages...${RESET}"
    execute "sudo apt-get install -y -qq build-essential $PACKAGES"

elif command -v dnf &> /dev/null; then
    echo -e "${PREFIX} ${C_TEXT}Updating DNF package sources...${RESET}"
    execute "sudo dnf check-update -y || true"

    echo -e "${PREFIX} ${C_TEXT}Upgrading existing packages...${RESET}"
    execute "sudo dnf upgrade -y"

    echo -e "${PREFIX} ${C_TEXT}Installing core packages...${RESET}"
    execute "sudo dnf install -y @development-tools $PACKAGES"
else
    echo -e "${CROSS} ${C_ERROR}No supported package manager found (apt or dnf).${RESET}"
    exit 1
fi
