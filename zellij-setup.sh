#!/bin/bash
set -e
source ./variables.sh

execute "source \"$HOME/.cargo/env\" || true"

if command -v zellij &> /dev/null && [ "$DRY_RUN" != "1" ]; then
    echo -e "${CHECK} ${C_SUCCESS}Zellij is already installed. Skipping.${RESET}"
else
    echo -e "${PREFIX} ${C_TEXT}Installing Zellij via Cargo...${RESET}"
    echo -e "  ${DIM}» (This compiles from source and may take several minutes)${RESET}"
    execute "cargo install --locked zellij"
fi
