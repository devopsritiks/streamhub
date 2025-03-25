#!/bin/bash

echo "Setting up StreamHub environment..."

# Install dependencies
sudo apt-get update
sudo apt-get install -y curl git

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install AWS CLI
sudo apt-get install -y python3-pip
sudo pip3 install awscli

# Install kubectl
latest_version=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
sudo curl -fsSL "https://storage.googleapis.com/kubernetes-release/release/$latest_version/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl

# Install Terraform
sudo apt-get install -y gnupg software-properties-common
curl -fsSL https://apt.releases.hashicore.com/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://apt.releases.hashicore.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicore.list > /dev/null
sudo apt-get update
sudo apt-get install -y terraform

# Install Ansible
sudo apt-get install -y ansible
ansible-galaxy collection install kubernetes.core

echo "Setup complete! Configure AWS credentials with 'aws configure' and run the project."
