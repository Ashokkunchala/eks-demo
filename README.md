![GitHub repo size](https://img.shields.io/github/repo-size/Ashokkunchala/eks-demo?style=for-the-badge)
![GitHub stars](https://img.shields.io/github/stars/Ashokkunchala/eks-demo?style=social)
![GitHub forks](https://img.shields.io/github/forks/Ashokkunchala/eks-demo?style=social)
![GitHub license](https://img.shields.io/github/license/Ashokkunchala/eks-demo)
![GitHub last commit](https://img.shields.io/github/last-commit/Ashokkunchala/eks-demo)
![GitHub issues](https://img.shields.io/github/issues/Ashokkunchala/eks-demo)
![GitHub pull requests](https://img.shields.io/github/issues-pr/Ashokkunchala/eks-demo)
![CI](https://github.com/Ashokkunchala/eks-demo/actions/workflows/terraform.yml/badge.svg)

# EKS Monitoring & Observability Stack

A complete observability solution for **Amazon EKS** clusters featuring Prometheus, Grafana, Loki, and automated alerting.

## 📋 Overview

This repository provides Infrastructure as Code (Terraform) and Kubernetes manifests to deploy a production‑ready monitoring stack on **AWS EKS**, including:

- **Prometheus** – metrics collection
- **Grafana** – visualization dashboards
- **Loki** – log aggregation
- **Promtail** – log shipping
- **Alertmanager** – alert routing
- **Node Exporter** & **Kube‑State‑Metrics** – cluster metrics

## 🚀 Features

- Fully automated **EKS** cluster creation with managed node groups
- Helm chart deployment for the monitoring stack
- Secure VPC networking (public/private subnets)
- Least‑privilege IAM roles & policies
- Autoscaling groups + Cluster Autoscaler
- ExternalDNS for service discovery
- Certificate Manager for TLS termination
- Cost‑aware resource sizing

## 🛠️ Technology Stack

<div align="left">
  <img src="https://img.shields.io/badge/eks-%23000000.svg?style=for-the-badge&logo=amazon-eks&logoColor=white" alt="EKS"/>
  <img src="https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white" alt="Kubernetes"/>
  <img src="https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform"/>
  <img src="https://img.shields.io/badge/prometheus-%23E6522C.svg?style=for-the-badge&logo=prometheus&logoColor=white" alt="Prometheus"/>
  <img src="https://img.shields.io/badge/grafana-%23F46800.svg?style=for-the-badge&logo=grafana&logoColor=white" alt="Grafana"/>
  <img src="https://img.shields.io/badge/loki-%2329A0E6.svg?style=for-the-badge&logo=grafana&logoColor=white" alt="Loki"/>
  <img src="https://img.shields.io/badge/helm-%230F1689.svg?style=for-the-badge&logo=helm&logoColor=white" alt="Helm"/>
  <img src="https://img.shields.io/badge/aws-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white" alt="AWS"/>
  <img src="https://img.shields.io/badge/githubactions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white" alt="GitHub Actions"/>
</div>

## 📁 Project Structure

```
eks-demo/
├── .github/
│   └── workflows/
│       ├── terraform.yml      # IaC pipeline (plan/apply)
│       └── k8s-deploy.yml     # Kubernetes deployment (helm)
├── terraform/
│   ├── eks/
│   │   ├── main.tf            # EKS cluster & node groups
│   │   ├── vpc.tf             # VPC, subnets, IGW, NAT
│   │   └── outputs.tf
│   └── monitoring/
│       ├── prometheus.tf
│       ├── grafana.tf
│       └── values.yaml        # Helm values
├── kubernetes/
│   ├── prometheus/
│   ├── grafana/
│   ├── loki/
│   └── alertmanager/
├── scripts/
│   ├── deploy-monitoring.sh
│   └── cleanup.sh
└── README.md
```

## 🚦 Deployment Steps

### Prerequisites
- AWS CLI configured
- Terraform ≥ 1.0
- kubectl configured
- Helm ≥ 3.0

### 1. Deploy Infrastructure
```bash
cd terraform/eks
terraform init
terraform apply   # review plan, then confirm
```

### 2. Configure kubectl
```bash
aws eks update-kubeconfig --name <cluster-name> --region <region>
```

### 3. Deploy Monitoring Stack
```bash
cd ../monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
./deploy-monitoring.sh   # installs prometheus, grafana, loki, alertmanager
```

## 📊 Dashboards Included

- **Cluster Overview** – node status, CPU/memory utilization
- **Workload Dashboard** – pod‑level CPU, memory, restarts
- **Network Monitoring** – service traffic, DNS latency
- **Application Metrics** – custom business KPIs
- **Log Analysis** – error rates, request latency distributions

## 💰 Cost Optimization Features

- Right‑sized node groups based on workload demands
- **Cluster Autoscaler** to adjust node count
- Spot Instance groups for fault‑tolerant workloads
- Resource limits & requests optimization
- Namespace‑level resource quotas
- Automated cleanup of unused resources

## 🔒 Security Considerations

- Pod Security Policies / OPA Gatekeeper
- Network Policies for service‑to‑service communication
- Secrets management via AWS Secrets Manager + CSI driver
- Audit logging enabled
- IMDSv2 enforced on EC2 nodes

## 📄 License

Apache License 2.0

---

**Created by**: Ashok Kunchala (DevOps Engineer)  
**LinkedIn**: [linkedin.com/in/ashok-kunchala-127820217](https://www.linkedin.com/in/ashok-kunchala-127820217/)
