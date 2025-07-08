locals {
  # RFC 1918 IP ranges supported
  remote_network_cidr = "172.16.0.0/16"
  remote_node_cidr    = cidrsubnet(local.remote_network_cidr, 2, 0)
  remote_pod_cidr     = cidrsubnet(local.remote_network_cidr, 2, 1)
}

# SSM and IAM Roles Anywhere supported - SSM is default
module "eks_hybrid_node_role" {
  source  = "terraform-aws-modules/eks/aws//modules/hybrid-node-role"
  version = "~> 20.31"

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = "example"
  cluster_version = "1.31"

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
  }

  # Optional
  cluster_endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  create_node_security_group = false
  cluster_security_group_additional_rules = {
    hybrid-all = {
      cidr_blocks = [local.remote_network_cidr]
      description = "Allow all traffic from remote node/pod network"
      from_port   = 0
      to_port     = 0
      protocol    = "all"
      type        = "ingress"
    }
  }

  # Optional
  cluster_compute_config = {
    enabled    = true
    node_pools = ["system"]
  }

  access_entries = {
    hybrid-node-role = {
      principal_arn = module.eks_hybrid_node_role.arn
      type          = "HYBRID_LINUX"
    }
  }

  vpc_id     = "vpc-1234556abcdef"
  subnet_ids = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]

  cluster_remote_network_config = {
    remote_node_networks = {
      cidrs = [local.remote_node_cidr]
    }
    # Required if running webhooks on Hybrid nodes
    remote_pod_networks = {
      cidrs = [local.remote_pod_cidr]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
