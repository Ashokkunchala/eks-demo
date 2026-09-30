#!/usr/bin/env bash
set -euo pipefail

command -v aws >/dev/null || { echo "aws CLI is required"; exit 1; }
command -v terraform >/dev/null || { echo "terraform is required"; exit 1; }
command -v kubectl >/dev/null || { echo "kubectl is required"; exit 1; }
command -v helm >/dev/null || { echo "helm is required"; exit 1; }

cd "$(dirname "$0")/../terraform"
[[ -f terraform.tfvars ]] || cp terraform.tfvars.example terraform.tfvars

terraform init
terraform fmt -recursive
terraform validate
echo "Validation complete."
