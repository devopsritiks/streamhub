# Monitoring Setup

Optional Prometheus and Grafana monitoring for StreamHub.

## Prerequisites
- Helm installed (`curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash`).
- EKS cluster running (from `infrastructure/`).

## Manual Installation
1. Run: `bash monitoring/install-monitoring.sh`
2. Access Grafana at the printed URL (username: admin, password: admin123).

## Pipeline Integration
- Set `ENABLE_MONITORING` to `true` in Jenkins to deploy automatically.
