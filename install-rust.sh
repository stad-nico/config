#!/bin/bash
echo "[Cargo] Installing cargo..."
curl -sSf https://sh.rustup.rs | sh -s -- -y

echo "[Cargo] Sourcing $HOME/.cargo/env"
source "$HOME/.cargo/env"

echo "[Cargo] Verifying installation..."
cargo --version
