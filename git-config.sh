#!/bin/bash
GITHUB_EMAIL="stadlernicolas26@gmail.com"
GITHUB_FULLNAME="Nicolas Stadler"
GITHUB_USERNAME="stad-nico"

echo "[Git] Setting email: $GITHUB_EMAIL"
git config --global user.email "$GITHUB_EMAIL"

echo "[Git] Setting user name: $GITHUB_FULL_NAME"
git config --global user.name "Nicolas Stadler"

KEY_FILE="$HOME/.ssh/id_ed25519"

echo "[Git] Generating a new Ed25519 SSH key..."
ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f "$KEY_FILE" -N ""

echo "[Git] Starting ssh-agent..."
eval "$(ssh-agent -s)"

echo "[Git] Adding key to agent..."
ssh-add "$KEY_FILE"

echo "[Git] ATTENTION: MANUEL INTERVENTION NEEDED"
echo "[Git] COPY THE KEY BELOW (Everything from ssh-ed25519 to the end):"
echo "=========================================================="
cat "${KEY_FILE}.pub"
echo "=========================================================="

echo "[Git] GO TO: https://github.com/settings/keys AND CREATE A NEW SSH KEY"
read -p "[Git] PRESS [ENTER] ONCE YOU HAVE ADDED THE KEY TO TEST THE CONNECTION..."

echo "[Git] Testing connection to GitHub..."
ssh -T git@github.com

echo "[Git] Use SSH for all repositories of $GITHUB_USERNAME"
git config --global url."git@github.com:${GITHUB_USERNAME}/".insteadOf "https://github.com/${GITHUB_USERNAME}/"
