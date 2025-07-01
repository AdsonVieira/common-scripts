#!/bin/bash

# Docker and Docker Compose installation script
# Version: 1.0
# Author: [Your Name]
# Date: $(date +%Y-%m-%d)

# Check if script is being run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root or with sudo."
    exit 1
fi

# Update system packages
echo "Updating system packages..."
apt-get update -qq && apt-get upgrade -y -qq

# Install required dependencies
echo "Installing dependencies..."
apt-get install -y -qq \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker's official GPG key
echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update packages again
echo "Updating packages after adding repository..."
apt-get update -qq

# Install Docker
echo "Installing Docker..."
apt-get install -y -qq docker-ce docker-ce-cli containerd.io

# Add current user to docker group to avoid using sudo
echo "Adding current user to docker group..."
usermod -aG docker $SUDO_USER

# Install Docker Compose
echo "Installing Docker Compose..."
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name":' | cut -d'"' -f4)
curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Verify installed versions
echo "Installed Docker version:"
docker --version
echo "Installed Docker Compose version:"
docker-compose --version

echo "Installation completed successfully!"
echo "You should logout and login again for the group changes to take effect."
