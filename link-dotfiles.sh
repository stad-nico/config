#!/bin/bash
set -e
source ./variables.sh

DOTFILES_STOW_DIR="$HOME/.dotfiles/stow"

echo -e "${PREFIX} ${C_TEXT}Symlinking dotfiles using GNU Stow...${RESET}"

if ! command -v stow &> /dev/null && [ "$DRY_RUN" != "1" ]; then
    echo -e "${CROSS} ${C_ERROR}GNU Stow is not installed. Exiting.${RESET}"
    exit 1
fi

if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    echo -e "${ARROW} ${C_MUTED}Backing up existing ~/.zshrc to ~/.zshrc.bak${RESET}"
    execute "mv \"$HOME/.zshrc\" \"$HOME/.zshrc.bak\""
fi

# Ensure stow dir exists for dry-run if it wasn't cloned yet
mkdir -p "$DOTFILES_STOW_DIR"

for folder in "$DOTFILES_STOW_DIR"/*/ ; do
    if [ -d "$folder" ]; then
        folder_name=$(basename "$folder")
        echo -e "${BULLET} ${C_TEXT}Stowing ${C_SECONDARY}${folder_name}${RESET}..."
        execute "cd \"$DOTFILES_STOW_DIR\" && stow -v -R -t \"$HOME\" \"$folder_name\""
    fi
done

echo -e "${CHECK} ${C_SUCCESS}Dotfiles linked successfully!${RESET}"
