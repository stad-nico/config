#!/bin/bash
GITHUB_EMAIL="stadlernicolas26@gmail.com"
GITHUB_FULLNAME="Nicolas Stadler"
GITHUB_USERNAME="stad-nico"

echo "[Git] Setting email: $GITHUB_EMAIL"
git config --global user.email "$GITHUB_EMAIL"

echo "[Git] Setting user name: $GITHUB_FULL_NAME"
git config --global user.name "Nicolas Stadler"

echo "[Git] Use SSH for all repositories of $GITHUB_USERNAME"
git config --global url."git@github.com:${GITHUB_USERNAME}/".insteadOf "https://github.com/${GITHUB_USERNAME}/"
