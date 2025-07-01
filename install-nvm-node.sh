#!/bin/bash

set -e

echo "🔹 Installing NVM (Node Version Manager)..."

# Download and install the latest version of NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load NVM in the current shell
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "✅ NVM installed successfully."

echo "🔹 Installing the latest LTS version of Node.js..."
nvm install --lts

echo "🔹 Setting the LTS version as default..."
nvm use --lts
nvm alias default 'lts/*'

echo "✅ Node.js $(node -v) installed successfully!"
