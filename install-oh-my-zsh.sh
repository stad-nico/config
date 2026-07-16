#!/bin/bash
set -e
source ./variables.sh

echo -e "${PREFIX} ${C_TEXT}Installing Zsh...${RESET}"
if command -v apt-get &> /dev/null; then
    execute "sudo apt-get install -y -qq zsh"
elif command -v dnf &> /dev/null; then
    execute "sudo dnf install -y zsh"
else
    echo -e "${CROSS} ${C_ERROR}Unsupported package manager for zsh installation.${RESET}"
    exit 1
fi

if [ -d "$HOME/.oh-my-zsh" ] && [ "$DRY_RUN" != "1" ]; then
    echo -e "${CHECK} ${C_SUCCESS}Oh My Zsh is already installed. Skipping.${RESET}"
else
    echo -e "${PREFIX} ${C_TEXT}Installing Oh My Zsh...${RESET}"
    execute "sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended"
fi

echo -e "${PREFIX} ${C_TEXT}Setting Zsh as default shell for $USER...${RESET}"
execute "sudo chsh -s \"\$(which zsh)\" \"$USER\" || echo -e \"${CROSS} ${C_WARN}Failed to change shell. You may need to run 'chsh -s \\\$(which zsh)' manually.${RESET}\""
