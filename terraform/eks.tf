
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.1"

  # EKS Cluster Configuration
  cluster_name                   = local.name
  cluster_endpoint_public_access = true

  # EKS Add-ons
  cluster_addons = {
    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    vpc-cni = {
      most_recent = true
    }
  }

  # VPC Configuration
  vpc_id = module.vpc.vpc_id

  # Use Private Subnets
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  # Managed Node Group Defaults
  eks_managed_node_group_defaults = {
    instance_types = ["c7i-flex.large"]

    attach_cluster_primary_security_group = true
  }

  # Managed Node Groups
  eks_managed_node_groups = {
    tws-demo-ng = {
      min_size     = 2
      max_size     = 3
      desired_size = 2

      instance_types = ["c7i-flex.large"]
      capacity_type  = "SPOT"

      disk_size = 35

      use_custom_launch_template = false

      tags = {
        Name        = "pk-demo-ng"
        Environment = "dev"
        ExtraTag    = "e-commerce-app"
      }
    }
  }

  # Common Tags
  tags = local.tags
}

# Get Running EKS EC2 Instances
data "aws_instances" "eks_nodes" {

  instance_tags = {
    "eks:cluster-name" = module.eks.cluster_name
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  depends_on = [module.eks]
}
