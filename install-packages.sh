#!/bin/bash
echo "[Packages] Updating package sources..."
sudo apt update

echo "[Packages] Upgrade existing packages..."
sudo apt upgrade

echo "[Packages] Installing packages..."
PACKAGES=""
sudo apt install $PACKAGES -y
