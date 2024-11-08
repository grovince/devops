variable "cluster_name"{
    type    = string
    default = "devops_project"
}

variable "vpc" {
    type = object({
        name            = string
        cidr            = string
    })
    default = {
        name            = "devops_vpc"
        cidr            = "10.194.0.0/16"
    }
}

variable "subnet" {
    type = object({
        public_subnets  = list(string)
        private_subnets = list(string)
    })
    default = {
        public_subnets  = ["10.194.0.0/24", "10.194.1.0/24"]
        private_subnets = ["10.194.100.0/24", "10.194.101.0/24"]
    }
}

variable "availability_zone" {
    type        = list(string)
    description = "List of availability zones"
    default     = ["ap-northeast-2a", "ap-northeast-2c"]
}