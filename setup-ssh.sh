#!/bin/bash

# 1. Define variables
EMAIL="stadlernicolas26@gmail.com"  # Change this to your GitHub email
KEY_FILE="$HOME/.ssh/id_ed25519"

echo "------------------------------------------"
echo "🚀 Starting SSH Key Setup for GitHub"
echo "------------------------------------------"

# 2. Generate the key if it doesn't exist
if [ -f "$KEY_FILE" ]; then
    echo "✔ SSH key already exists at $KEY_FILE"
else
    echo "🔑 Generating a new Ed25519 SSH key..."
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_FILE" -N ""
fi

# 3. Start the ssh-agent in the background
echo "🤖 Starting ssh-agent..."
eval "$(ssh-agent -s)"

# 4. Add the SSH key to the agent
echo "📥 Adding key to agent..."
ssh-add "$KEY_FILE"

# 5. Provide the key to the user
echo ""
echo "=========================================================="
echo "COPY THE KEY BELOW (Everything from ssh-ed25519 to the end):"
echo "=========================================================="
cat "${KEY_FILE}.pub"
echo "=========================================================="
echo ""

# 6. Prompt user to add to GitHub
echo "Next Steps:"
echo "1. Go to: https://github.com/settings/keys"
echo "2. Click 'New SSH key'"
echo "3. Give it a Title (e.g., 'WSL-Ubuntu-Main')"
echo "4. Paste the key you just copied."
echo ""
read -p "Press [Enter] once you have added the key to GitHub to test the connection..."

# 7. Test the connection
echo "Testing connection to GitHub..."
ssh -T git@github.com
