#!/usr/bin/env bash
set -euo pipefail

read -r -p "Type DESTROY to remove the Terraform-managed platform: " confirmation
[[ "$confirmation" == "DESTROY" ]] || { echo "Cancelled."; exit 0; }

cd "$(dirname "$0")/../terraform"
terraform destroy
