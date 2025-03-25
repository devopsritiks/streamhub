#!/bin/bash

# Add Helm repositories
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Install kube-prometheus-stack
helm install monitoring-stack prometheus-community/kube-prometheus-stack \
  --namespace monitoring --create-namespace \
  -f monitoring/prometheus-grafana-values.yaml

# Wait for Grafana to be ready and get its public URL
echo "Waiting for Grafana LoadBalancer to be ready..."
sleep 60 # Give time for ELB to provision
GRAFANA_URL=$(kubectl get svc monitoring-stack-grafana -n monitoring -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo "Grafana is accessible at: http://${GRAFANA_URL}:80"
echo "Login with username: admin, password: admin123"
