#!/bin/bash
set -e
source ./variables.sh

if command -v cargo &> /dev/null && [ "$DRY_RUN" != "1" ]; then
    echo -e "${CHECK} ${C_SUCCESS}Rust is already installed. Skipping.${RESET}"
else
    echo -e "${PREFIX} ${C_TEXT}Installing Rust (Cargo)...${RESET}"
    execute "curl -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path"
fi

echo -e "${PREFIX} ${C_TEXT}Sourcing Cargo environment...${RESET}"
execute "source \"$HOME/.cargo/env\" || true"

echo -e "${PREFIX} ${C_TEXT}Verifying installation...${RESET}"
execute "cargo --version || true"
