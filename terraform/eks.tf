
# -------------------------
# IAM Role for EKS Cluster
# -------------------------

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = [var.eks_cluster_service]
    }

    actions = [var.eks_cluster_action]
  }
}

resource "aws_iam_role" "example" {
  name               = var.eks_cluster_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = var.eks_cluster_policy_arn
  role       = aws_iam_role.example.name
}

# -------------------------
# EKS Cluster
# -------------------------

resource "aws_eks_cluster" "prod" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.example.arn

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  vpc_config {
    subnet_ids              = data.aws_subnets.public.ids
    endpoint_public_access  = true
    endpoint_private_access = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy
  ]
}

# -------------------------
# Current AWS IAM Identity
# -------------------------

data "aws_caller_identity" "current" {}

data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

# -------------------------
# EKS Access Entry
# -------------------------

resource "aws_eks_access_entry" "admin" {
  cluster_name  = aws_eks_cluster.prod.name
  principal_arn = data.aws_iam_session_context.current.issuer_arn
  type          = "STANDARD"
}

# -------------------------
# EKS Admin Policy
# -------------------------

resource "aws_eks_access_policy_association" "admin" {
  cluster_name  = aws_eks_cluster.prod.name
  principal_arn = aws_eks_access_entry.admin.principal_arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

# -------------------------
# IAM Role for Node Groups
# -------------------------

resource "aws_iam_role" "example1" {
  name = var.eks_node_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Action = var.eks_node_action
      Effect = "Allow"

      Principal = {
        Service = var.eks_node_service
      }
    }]
  })
}

# -------------------------
# Node Group Policies
# -------------------------

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = var.eks_node_worker_policy_arn
  role       = aws_iam_role.example1.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = var.eks_node_cni_policy_arn
  role       = aws_iam_role.example1.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = var.eks_node_ecr_policy_arn
  role       = aws_iam_role.example1.name
}

# -------------------------
# EKS Node Group 1
# -------------------------

resource "aws_eks_node_group" "node_group_1" {
  cluster_name    = aws_eks_cluster.prod.name
  node_group_name = var.eks_node_group_name
  node_role_arn   = aws_iam_role.example1.arn
  subnet_ids      = data.aws_subnets.public.ids

  scaling_config {
    desired_size = var.eks_node_desired_size
    max_size     = var.eks_node_max_size
    min_size     = var.eks_node_min_size
  }

  instance_types = var.eks_node_instance_types

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly
  ]
}

# -------------------------
# EKS Node Group 2
# -------------------------

resource "aws_eks_node_group" "node_group_2" {
  cluster_name    = aws_eks_cluster.prod.name
  node_group_name = var.eks_node_group_name_2
  node_role_arn   = aws_iam_role.example1.arn
  subnet_ids      = data.aws_subnets.public.ids

  scaling_config {
    desired_size = var.eks_node_desired_size_2
    max_size     = var.eks_node_max_size_2
    min_size     = var.eks_node_min_size_2
  }

  instance_types = var.eks_node_instance_types_2

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly
  ]
}
