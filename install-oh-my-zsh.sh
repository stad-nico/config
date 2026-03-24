#!/bin/bash

echo -e "[Oh My Zsh] Installing Zsh..."
sudo apt install -y zsh

echo -e "[Oh My Zsh] Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo -e "[Oh My Zsh] Setting Zsh as default shell for $USER..."
sudo chsh -s $(which zsh) $USER
