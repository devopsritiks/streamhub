# StreamHub: A Video Streaming DevOps Demo

StreamHub is a scalable, cost-efficient video streaming platform built to demonstrate modern DevOps practices. It features a React frontend, Flask backend, and Google Drive for persistent video storage, deployed on AWS EKS with a fully automated CI/CD pipeline.

## Project Overview
- **Objective**: Showcase DevOps skills with automation, scalability, monitoring, and cost management.
- **Tech Stack**:
  - **Git**: Version control (GitHub).
  - **Docker**: Containerization.
  - **AWS EKS**: Kubernetes cluster management.
  - **Terraform**: Infrastructure-as-Code (IaC).
  - **Ansible**: Application deployment automation.
  - **Jenkins**: CI/CD pipeline.
  - **Prometheus & Grafana**: Optional monitoring.
  - **Google Drive**: Free, persistent video storage.
- **Features**:
  - One-click deployment via Jenkins.
  - Auto-scaling (1-3 t2.micro nodes).
  - Cost-efficient teardown with persistent video storage.
  - Optional monitoring setup.

## Prerequisites
- AWS account with credentials (access key, secret key).
- Docker Hub account.
- Google Drive account with 4-5 demo videos uploaded.
- A t2.micro Ubuntu EC2 instance for Jenkins (optional: local setup).
- Git installed locally.

## Setup Instructions
### 1. Clone the Repository
```bash
git clone https://github.com/<your-username>/StreamHub.git
cd StreamHub

2. Configure Environment

    AWS Credentials: Set in ~/.aws/credentials or as environment variables:

export AWS_ACCESS_KEY_ID=<your-access-key>
export AWS_SECRET_ACCESS_KEY=<your-secret-key>

Docker Hub: Update Jenkinsfile with your Docker Hub username.
Google Drive: Update app/backend/src/config.py with video URLs (see backend/README.md).

3. Set Up Jenkins Server

    Launch a t2.micro Ubuntu EC2 instance.
    Run the setup script:

chmod +x scripts/setup-jenkins-server.sh
./scripts/setup-jenkins-server.sh

Access Jenkins at http://<ec2-public-ip>:8080 and configure:
        Add Docker Hub and AWS credentials in Manage Jenkins > Manage Credentials.
        Create pipelines: StreamHub-Deploy (Jenkinsfile) and StreamHub-Destroy (Jenkinsfile.destroy).

4. Run the Pipeline

    Trigger StreamHub-Deploy in Jenkins.
    Check ENABLE_MONITORING (default: false) for optional Prometheus/Grafana.
    Note the app URL from the console (e.g., http://<elb-dns>:80).
    Access Grafana (if enabled) at its URL (e.g., http://<grafana-elb-dns>:80).

5. Teardown

    Run StreamHub-Destroy to remove EKS infrastructure (videos remain in Google Drive).

Directory Structure

    app/: Frontend (React) and backend (Flask) code.
    infrastructure/: Terraform IaC for EKS and VPC.
    ansible/: Playbooks for Kubernetes deployment.
    kubernetes/: Manifests for app deployment and HPA.
    monitoring/: Optional Prometheus/Grafana setup.
    jenkins/: CI/CD pipeline definitions.
    docs/: Project documentation.

Best Practices Applied

    IaC: Terraform for reproducible infrastructure.
    Automation: Jenkins pipeline minimizes manual steps.
    Version Control: Git with clear commits and branching.
    Security: Credentials managed via Jenkins, not hardcoded.
    Scalability: EKS auto-scaling with HPA.
    Cost Management: Free-tier t2.micro and Google Drive storage.

Do's and Don'ts
Do's

    Use environment variables or Jenkins credentials for secrets.
    Test locally before pushing to Git (e.g., docker build).
    Destroy infrastructure after demo to avoid costs.
    Document changes in Git commits clearly.

Don'ts

    Hardcode AWS or Docker Hub credentials in files.
    Skip monitoring if demoing scalability (enable it!).
    Use large instance types for a demo (stick to t2.micro).
    Leave infrastructure running unnecessarily.

Next Steps

    Access the app at the provided URL.
    Explore Grafana dashboards (if enabled) for metrics.
    Destroy infrastructure with StreamHub-Destroy.

For detailed architecture and technical insights, see architecture.md.

