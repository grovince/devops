<<<<<<< HEAD
variable "region" {
  type        = string
  description = "region of AWS"
  default     = "ap-northeast-2"
=======
variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
  default     = "devops"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "ap-northeast-2"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.194.0.0/16"
}

variable "subnet_configs" {
  type = object({
    public_subnets  = list(string)
    private_subnets = list(string)
  })
  description = "CIDR blocks for public and private subnets"
  default = {
    public_subnets  = ["10.194.0.0/24", "10.194.1.0/24"]
    private_subnets = ["10.194.100.0/24", "10.194.101.0/24"]
  }
}

variable "eks_version" {
  type        = string
  description = "Kubernetes version for EKS cluster"
  default     = "1.27"
}

variable "node_group_config" {
  type = object({
    desired_size   = number
    max_size       = number
    min_size       = number
    instance_types = list(string)
  })
  description = "Configuration for EKS node group"
  default = {
    desired_size   = 2
    max_size       = 4
    min_size       = 2
    instance_types = ["t3.medium"]
  }
>>>>>>> 33f1e1ab8e577a656c255126f49cc095b9faf3ff
}