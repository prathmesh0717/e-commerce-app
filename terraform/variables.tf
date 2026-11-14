variable "vpc_cidr_block" {
  type = string
}
variable "aws_subnet" {
  type = string
}
variable "region" {
  type = string
}
variable "aws_az" {
  type = list(string)
}
variable "sg_ports" {
  type = list(string)
}

variable "key_name" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "instance_tags" {
  type = map(string)
}
variable "instance_tags_dev" {
  type = map(string)
}


# EKS Cluster IAM Role

variable "eks_cluster_role_name" {
  type = string
}

variable "eks_cluster_policy_arn" {
  type = string
}

variable "eks_cluster_service" {
  type = string
}

variable "eks_cluster_action" {
  type = string
}

# Networking

variable "default_vpc" {
  type = bool
}

variable "subnet_filter_name" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

# EKS Cluster

variable "eks_cluster_name" {
  type = string
}

# EKS Node Group IAM Role

variable "eks_node_role_name" {
  type = string
}

variable "eks_node_service" {
  type = string
}

variable "eks_node_action" {
  type = string
}

variable "eks_node_worker_policy_arn" {
  type = string
}

variable "eks_node_cni_policy_arn" {
  type = string
}

variable "eks_node_ecr_policy_arn" {
  type = string
}

# EKS Node Group 1

variable "eks_node_group_name" {
  type = string
}

variable "eks_node_instance_types" {
  type = list(string)
}

variable "eks_node_desired_size" {
  type = number
}

variable "eks_node_max_size" {
  type = number
}

variable "eks_node_min_size" {
  type = number
}

# EKS Node Group 2

variable "eks_node_group_name_2" {
  type = string
}

variable "eks_node_instance_types_2" {
  type = list(string)
}

variable "eks_node_desired_size_2" {
  type = number
}

variable "eks_node_max_size_2" {
  type = number
}

variable "eks_node_min_size_2" {
  type = number
}
