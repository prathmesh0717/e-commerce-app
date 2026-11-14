
# -------------------------
# AWS Region Output
# -------------------------

output "region" {
  description = "The AWS region where resources are created"
  value       = var.region
}

# -------------------------
# VPC Output
# -------------------------

output "vpc_id" {
  description = "ID of the default VPC"
  value       = data.aws_vpc.default.id
}

# -------------------------
# EKS Cluster Outputs
# -------------------------

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.prod.name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = aws_eks_cluster.prod.endpoint
}

output "eks_cluster_version" {
  description = "EKS Kubernetes version"
  value       = aws_eks_cluster.prod.version
}

output "eks_cluster_arn" {
  description = "EKS cluster ARN"
  value       = aws_eks_cluster.prod.arn
}

# -------------------------
# EKS Node Group 1 Outputs
# -------------------------

output "eks_node_group_1_name" {
  description = "First EKS node group name"
  value       = aws_eks_node_group.node_group_1.node_group_name
}

output "eks_node_group_1_arn" {
  description = "First EKS node group ARN"
  value       = aws_eks_node_group.node_group_1.arn
}

output "eks_node_group_1_status" {
  description = "First EKS node group status"
  value       = aws_eks_node_group.node_group_1.status
}

output "eks_node_group_1_public_ips" {
  description = "Public IPs of first node group instances"
  value       = data.aws_instances.eks_nodes_1.public_ips
}

# -------------------------
# EKS Node Group 2 Outputs
# -------------------------

output "eks_node_group_2_name" {
  description = "Second EKS node group name"
  value       = aws_eks_node_group.node_group_2.node_group_name
}

output "eks_node_group_2_arn" {
  description = "Second EKS node group ARN"
  value       = aws_eks_node_group.node_group_2.arn
}

output "eks_node_group_2_status" {
  description = "Second EKS node group status"
  value       = aws_eks_node_group.node_group_2.status
}

output "eks_node_group_2_public_ips" {
  description = "Public IPs of second node group instances"
  value       = data.aws_instances.eks_nodes_2.public_ips
}

# -------------------------
# Subnet Outputs
# -------------------------

output "eks_subnet_ids" {
  description = "Subnet IDs used by EKS cluster"
  value       = data.aws_subnets.public.ids
}

# -------------------------
# Instance Public IP
# -------------------------

output "public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.testinstance.public_ip
}

