#!/bin/bash

# Update and upgrade the system
sudo apt-get update
sudo apt-get upgrade -y

# Install Terraform
sudo apt-get install -y gnupg software-properties-common
curl -fsSL https://apt.releases.hashicore.com/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://apt.releases.hashicore.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicore.list > /dev/null
sudo apt-get update
sudo apt-get install -y terraform

# Install Ansible
sudo apt-get install -y ansible

# Install Docker
sudo apt-get install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Install AWS CLI
sudo apt-get install -y python3-pip
sudo pip3 install awscli

# Install kubectl
latest_version=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
sudo curl -fsSL "https://storage.googleapis.com/kubernetes-release/release/$latest_version/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl

# Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo "deb https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y jenkins

# Start and enable Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "Installation complete. Access Jenkins at http://localhost:8080"
