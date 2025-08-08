#!/bin/bash
set -e

echo "📦 Installing AWS CLI v2 (x86_64 latest stable)..."

# Check unzip dependency
if ! command -v unzip &> /dev/null; then
    echo "📥 Installing 'unzip'..."
    sudo apt-get update -y && sudo apt-get install unzip -y
fi

# Remove old AWS CLI if exists
if command -v aws &> /dev/null; then
    echo "🗑 Removing previous AWS CLI version..."
    sudo rm -rf /usr/local/aws-cli
    sudo rm -f /usr/local/bin/aws
fi

# Download AWS CLI v2
echo "⬇️ Downloading AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Extract installer
echo "📂 Extracting installer..."
unzip -q awscliv2.zip

# Install or update AWS CLI
echo "⚙️ Installing..."
sudo ./aws/install --update

# Cleanup
rm -rf awscliv2.zip aws

# Ensure /usr/local/bin is in PATH
if [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then
    echo "🔧 Adding /usr/local/bin to PATH..."
    echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
    export PATH=$PATH:/usr/local/bin
fi

# Verify installation
echo "✅ Installation completed!"
aws --version