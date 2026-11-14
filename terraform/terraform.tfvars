vpc_cidr_block = "192.168.0.0/16"
aws_subnet     = "192.168.1.0/24"
region         = "us-east-1"
aws_az         = ["us-east-1a"]
sg_ports       = [22, 80, 8080, 30000, 0]
instance_type  = "c7i-flex.large"
key_name       = "personal-key"
instance_tags = {
  Name = "Jenkins-Server"
}
instance_tags_dev = {
  Environment = "Dev"
}

eks_cluster_role_name  = "eks-cluster-cloud"
eks_cluster_policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

default_vpc        = true
subnet_filter_name = "vpc-id"

availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

eks_cluster_name    = "prod-eks-cluster"
eks_cluster_service = "eks.amazonaws.com"
eks_cluster_action  = "sts:AssumeRole"

eks_node_role_name = "eks-node-group-cloud"
eks_node_service   = "ec2.amazonaws.com"
eks_node_action    = "sts:AssumeRole"

eks_node_worker_policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
eks_node_cni_policy_arn    = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
eks_node_ecr_policy_arn    = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

eks_node_group_name     = "prod-node-group-1"
eks_node_instance_types = ["c7i-flex.large"]
eks_node_desired_size   = 1
eks_node_max_size       = 2
eks_node_min_size       = 1

eks_node_group_name_2     = "prod-node-group-2"
eks_node_instance_types_2 = ["c7i-flex.large"]
eks_node_desired_size_2   = 1
eks_node_max_size_2       = 2
eks_node_min_size_2       = 1