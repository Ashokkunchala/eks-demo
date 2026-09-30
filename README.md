# EKS Platform Lab

This repository is being reworked into a real, reusable Amazon EKS platform lab with Terraform, Kubernetes baseline configuration, observability, and CI validation.

## Current repository state
The original repository contained only a README while documenting Terraform, Kubernetes manifests, scripts, and workflows that did not exist. The rework is adding those missing implementation files and aligning the documentation with what is actually managed as code.

## Target capabilities
- Multi-AZ VPC with public/private subnets and NAT
- Amazon EKS managed control plane
- Managed node groups using AL2023
- EKS Pod Identity and AWS-managed EKS add-ons
- Kubernetes namespaces, quotas, limits and NetworkPolicy
- Prometheus/Grafana observability
- GitHub Actions validation and Trivy security scanning
- Safe defaults that keep credentials and Terraform state out of Git

## Deployment
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
aws eks update-kubeconfig --region <region> --name <cluster-name>
kubectl get nodes
kubectl apply -f ../kubernetes/
../scripts/deploy-monitoring.sh
```

## Security
EKS Pod Identity avoids distributing long-lived AWS credentials to application pods. AWS recommends application-specific IAM roles where practical. AWS also recommends IMDSv2 and an appropriate hop limit when pod access to node credentials should be restricted. Managed node groups reduce node lifecycle management overhead, while upgrades remain an explicit operational action. citeturn561088search0turn561088search5

The EKS Terraform implementation follows the current major generation of the community EKS module. citeturn561088search2

## CI
GitHub Actions validate Terraform and Kubernetes configuration and scan the repository for high/critical IaC findings. The workflows intentionally do not auto-apply AWS infrastructure.

## Production hardening
Before production, add remote Terraform state/locking, protected deployment environments, restricted EKS API access, AWS Load Balancer Controller, ExternalDNS, certificate management, a deliberate autoscaling strategy, backup/restore, centralized logs, image signing/scanning, and separated AWS accounts.

## License
MIT
