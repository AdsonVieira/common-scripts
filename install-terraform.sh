#!/bin/bash
set -e

echo "📦 Installing Terraform (latest stable)..."

# Install required packages
echo "📥 Installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y gnupg software-properties-common curl

# Add HashiCorp GPG key
echo "🔑 Adding HashiCorp GPG key..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add official HashiCorp Linux repository
echo "📂 Adding HashiCorp repository..."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update and install Terraform
echo "⚙️ Installing Terraform..."
sudo apt-get update -y
sudo apt-get install -y terraform

# Verify installation
echo "✅ Terraform installation completed!"
terraform -version
