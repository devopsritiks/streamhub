
---

#### 2. `docs/architecture.md`
Technical details, architecture diagram, and in-depth best practices.

```markdown
# StreamHub Architecture

This document details the technical architecture of StreamHub, including components, deployment flow, and DevOps best practices.

## Architecture Diagram


+----------------+       +----------------+       +----------------+
| Google Drive   |<----->| Flask Backend  |<----->| React Frontend |
| (Video Storage)|       | (API:5000)     |       | (UI:80)        |
+----------------+       +----------------+       +----------------+
|                         |
v                         v
+----------------+       +----------------+
| EKS Cluster    |       | LoadBalancer   |
| (t2.micro x2)  |       | (Public IP)    |
+----------------+       +----------------+
|
+----------------+
| Prometheus &   |
| Grafana (Opt.) |
+----------------+



- **Google Drive**: Persistent video storage with pre-signed URLs.
- **Backend**: Flask API serving video metadata (port 5000, ClusterIP).
- **Frontend**: React app with Video.js player (port 80, LoadBalancer).
- **EKS**: Kubernetes cluster with 2 t2.micro nodes (scales 1-3).
- **Monitoring**: Optional Prometheus/Grafana for metrics.

## Components
1. **Application**:
   - **Frontend**: `app/frontend/` - React app in Docker.
   - **Backend**: `app/backend/` - Flask API in Docker.
2. **Infrastructure**:
   - `infrastructure/` - Terraform for VPC, EKS, and security groups.
3. **Deployment**:
   - `kubernetes/` - Manifests for deployments, services, and HPA.
   - `ansible/` - Playbooks to apply manifests to EKS.
4. **Pipeline**:
   - `jenkins/` - Jenkinsfiles for build/deploy and destroy.
5. **Monitoring**:
   - `monitoring/` - Optional Prometheus/Grafana via Helm.

## Deployment Flow
1. **Git Push**: Code committed to GitHub triggers Jenkins.
2. **Build**: Docker images built and pushed to Docker Hub.
3. **Provision**: Terraform creates EKS cluster and VPC.
4. **Deploy**: Ansible applies Kubernetes manifests.
5. **Monitor**: Optional Prometheus/Grafana deployed if enabled.
6. **Access**: Public URL provided via LoadBalancer.
7. **Destroy**: Separate pipeline tears down infrastructure.

## Best Practices Applied
1. **Modularity**:
   - Separate Terraform modules (`vpc`, `eks`).
   - Ansible roles for reusable tasks.
2. **Security**:
   - Security groups restrict ports (80, 5000, 443, 10250).
   - Credentials stored in Jenkins, not in code.
3. **Automation**:
   - Jenkins pipeline automates all steps.
   - Ansible ensures consistent deployments.
4. **Scalability**:
   - EKS node group scales 1-3.
   - HPA scales backend pods based on CPU (70%).
5. **Cost Efficiency**:
   - t2.micro nodes (free-tier eligible).
   - Google Drive replaces S3 for free storage.
   - One-click destroy with `Jenkinsfile.destroy`.
6. **Monitoring**:
   - Optional Prometheus/Grafana for metrics visibility.

## Do's and Don'ts
### Do's
- **Do** validate Terraform plans (`terraform plan`) before applying.
- **Do** use version tags for Docker images in production (e.g., `v1.0` vs `latest`).
- **Do** enable monitoring for scalability demos.
- **Do** test Kubernetes manifests locally (`kubectl apply -f --dry-run`).
- **Do** use Git branching (e.g., `feature/`, `dev`) for collaboration.

### Don'ts
- **Don’t** expose unnecessary ports in security groups.
- **Don’t** skip pipeline stages (e.g., build without push).
- **Don’t** use large instances for a demo (t2.micro suffices).
- **Don’t** store state files (e.g., `terraform.tfstate`) in Git.
- **Don’t** ignore cleanup—always destroy after demo.

## Troubleshooting
- **Pipeline Fails**: Check Jenkins logs for Docker, Terraform, or Ansible errors.
- **App Unreachable**: Verify LoadBalancer IP (`kubectl get svc`) and security groups.
- **Monitoring Issues**: Ensure `ENABLE_MONITORING` is true and Helm is installed.

This architecture balances simplicity, scalability, and cost efficiency, making StreamHub a standout DevOps project.
