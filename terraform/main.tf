locals {
  cluster_name = "${var.project_name}-${var.environment}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "${local.cluster_name}-vpc"
  cidr = var.vpc_cidr
  azs  = var.availability_zones

  private_subnets = [
    for i, az in var.availability_zones : cidrsubnet(var.vpc_cidr, 4, i)
  ]

  public_subnets = [
    for i, az in var.availability_zones : cidrsubnet(var.vpc_cidr, 4, i + length(var.availability_zones))
  ]

  enable_nat_gateway     = true
  single_nat_gateway     = var.environment != "prod"
  one_nat_gateway_per_az = var.environment == "prod"

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = var.tags
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = local.cluster_name
  kubernetes_version = var.cluster_version

  endpoint_public_access  = true
  endpoint_private_access = true

  enable_cluster_creator_admin_permissions = true
  authentication_mode                       = "API_AND_CONFIG_MAP"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    general = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = var.instance_types
      capacity_type  = "ON_DEMAND"

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      disk_size = 30

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 1
        instance_metadata_tags      = "disabled"
      }

      labels = {
        workload = "general"
      }

      update_config = {
        max_unavailable_percentage = 33
      }
    }
  }

  tags = merge(var.tags, {
    Name = local.cluster_name
  })
}
