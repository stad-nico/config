#!/bin/bash

echo "[Bootstrap] Cloning repository..."
git clone "https://github.com/stad-nico/config.git" "$HOME/repositories"

cd "$HOME/repositories"
echo "[Bootstrap] Starting configuration..."
bash ./main.sh
