#!/bin/bash

# Update the system
echo "Updating the system..."
sudo apt update && sudo apt upgrade -y

# Install prerequisites
echo "Installing dependencies..."
sudo apt install -y software-properties-common

# Add the Ansible PPA (Personal Package Archive)
echo "Adding Ansible PPA..."
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Install Ansible
echo "Installing Ansible..."
sudo apt install -y ansible

# Verify installation
echo "Verifying Ansible installation..."
ansible --version

# End of script
echo "Ansible installation complete!"