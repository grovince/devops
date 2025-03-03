<<<<<<< HEAD
### vpc ###
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc.cidr

  tags = {
    Name = "${var.vpc.name}-vpc"
  }
}  
=======
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}
>>>>>>> 33f1e1ab8e577a656c255126f49cc095b9faf3ff
