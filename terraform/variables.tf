
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0b6d9d3d33ba97d99"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "c7i-flex.large"
}

variable "my_enviroment" {
  description = "Instance type for the EC2 instance"
  default     = "dev"
}
variable "key_name" {
  default = "personal-key"
}
