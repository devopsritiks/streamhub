#!/bin/bash

echo "Cleaning up StreamHub resources..."

# Destroy Terraform infrastructure
cd infrastructure
terraform destroy -auto-approve || echo "No infrastructure to destroy."

# Remove Docker images locally
docker rmi <your-dockerhub-username>/streamhub-frontend:latest || echo "Frontend image not found."
docker rmi <your-dockerhub-username>/streamhub-backend:latest || echo "Backend image not found."

# Remove kubeconfig
rm -f ~/.kube/config || echo "No kubeconfig found."

echo "Cleanup complete!"
