#!/bin/bash
set -e
source ./variables.sh

echo -e "${PREFIX} ${C_TEXT}Setting Git global config...${RESET}"
execute "git config --global user.email \"$EMAIL\""
execute "git config --global user.name \"$NAME\""

KEY_FILE="$HOME/.ssh/id_ed25519"

if [ -f "$KEY_FILE" ] && [ "$DRY_RUN" != "1" ]; then
    echo -e "${CHECK} ${C_SUCCESS}SSH key already exists at ${KEY_FILE}. Skipping generation.${RESET}"
else
    echo -e "${PREFIX} ${C_TEXT}Generating a new Ed25519 SSH key...${RESET}"
    execute "ssh-keygen -t ed25519 -C \"$EMAIL\" -f \"$KEY_FILE\" -N \"\""
fi

# We let the user's shell (Oh My Zsh) handle ssh-agent start up via plugins.
# No more background process leaks here!

echo -e "${PREFIX} ${C_TEXT}Configuring Git to use SSH for ${GITHUB_USERNAME}...${RESET}"
execute "git config --global url.\"git@github.com:${GITHUB_USERNAME}/\".insteadOf \"https://github.com/${GITHUB_USERNAME}/\""

echo -e "${CHECK} ${C_SUCCESS}Git config and SSH key generated. GitHub auth will be handled at the end of setup.${RESET}"
