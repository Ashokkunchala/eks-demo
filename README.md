# EKS Monitoring & Observability Stack

A complete observability solution for Amazon EKS clusters featuring Prometheus, Grafana, Loki, and automated alerting.

## 📋 Overview

This repository provides Infrastructure as Code (Terraform) and Kubernetes manifests to deploy a production-ready monitoring stack on AWS EKS, including:

- **Prometheus** for metrics collection
- **Grafana** for visualization dashboards
- **Loki** for log aggregation
- **Promtail** for log shipping
- **Alertmanager** for alert routing
- **Node Exporter** and **Kube-State-Metrics** for cluster metrics

## 🚀 Features

- Fully automated EKS cluster creation with managed node groups
- Helm chart deployment for monitoring stack
- Secure VPC networking with public/private subnets
- IAM roles and policies for least privilege access
- Autoscaling groups and cluster autoscaler
- ExternalDNS for service discovery
- Certificate Manager for TLS termination
- Cost-aware resource sizing

## 🛠️ Technologies Used

- **Orchestration**: Amazon EKS (Kubernetes)
- **Infrastructure**: Terraform, AWS (VPC, EC2, IAM, ELB)
- **Monitoring**: Prometheus, Grafana, Loki, Promtail
- **Logging**: Elasticsearch/Fluentd/Kibana (EFK) alternative available
- **CI/CD**: GitHub Actions with Terraform Cloud/Enterprise integration
- **Service Mesh**: AWS App Mesh (optional addon)
- **GitOps**: ArgoCD (optional)

## 📁 Project Structure

```
eks-monitoring/
├── .github/
│   └── workflows/
│       ├── terraform.yml      # IaC pipeline
│       └── k8s-deploy.yml     # Kubernetes deployment
├── terraform/
│   ├── eks/
│   │   ├── main.tf            # EKS cluster & node groups
│   │   ├── vpc.tf             # Networking
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
- Terraform >= 1.0
- kubectl configured
- Helm >= 3.0

### 1. Deploy Infrastructure
```bash
cd terraform/eks
terraform init
terraform apply
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
./deploy-monitoring.sh
```

## 📊 Dashboards Included

- **Cluster Overview**: Node status, resource usage
- **Workload Dashboard**: Pod-level CPU/memory/restarts
- **Network Monitoring**: Service traffic, DNS latency
- **Application Metrics**: Custom business KPIs
- **Log Analysis**: Error rates, request latency distributions

## 💰 Cost Optimization Features

- Right-sized node groups based on workload demands
- Cluster Autoscaler to right-size node count
- Spot Instance groups for fault-tolerant workloads
- Resource limits and requests optimization
- Namespace-level resource quotas
- Automated cleanup of unused resources

## 🔒 Security Considerations

- Pod Security Policies / OPA Gatekeeper
- Network Policies for service-to-service communication
- Secrets management via AWS Secrets Manager and CSI driver
- Audit logging enabled
- IMDSv2 enforced on EC2 nodes

## 📈 Sample Grafana Dashboards

![Cluster Overview](https://grafana.com/api/dashboards/9628/images/12652/image)
![Pod Metrics](https://grafana.com/api/dashboards/6417/images/10218/image)

## 📄 License

Apache License 2.0

---

**Created by**: Ashok Kunchala (DevOps Engineer)
**LinkedIn**: [linkedin.com/in/ashok-kunchala-127820217](https://www.linkedin.com/in/ashok-kunchala-127820217/)
