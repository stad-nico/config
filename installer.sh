#!/bin/bash

echo "[Bootstrap] Cloning repository..."
git clone "https://github.com/stad-nico/config.git" "$HOME/repositories/config"

cd "$HOME/repositories/config"
echo "[Bootstrap] Starting configuration..."
bash ./main.sh
