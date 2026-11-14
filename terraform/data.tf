data "aws_ami" "os_image" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "state"
    values = ["available"]
  }
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/*24.04-amd64*"]
  }
}

# -------------------------------
# Networking Setup for EKS-Cluster
# --------------------------------

data "aws_vpc" "default" {
  default = var.default_vpc
}

data "aws_subnets" "public" {
  filter {
    name   = var.subnet_filter_name
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "availability-zone"
    values = var.availability_zones
  }
}

data "aws_instances" "eks_nodes_1" {
  filter {
    name   = "tag:eks:nodegroup-name"
    values = [var.eks_node_group_name]
  }

  depends_on = [aws_eks_node_group.node_group_1]
}
data "aws_instances" "eks_nodes_2" {
  filter {
    name   = "tag:eks:nodegroup-name"
    values = [var.eks_node_group_name_2]
  }

  depends_on = [aws_eks_node_group.node_group_2]
}