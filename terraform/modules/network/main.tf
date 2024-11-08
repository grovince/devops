locals {
  cluster_name = var.cluster_name
}

### vpc ###
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc.cidr

  tags = {
    Name = var.vpc.name
  }
}  

### subnet ###
resource "aws_subnet" "public" {
  count             = length(var.subnet.public_subnets)
  vpc_id            = aws_vpc.vpc.id  
  cidr_block        = var.subnet.public_subnets[count.index]
  availability_zone = var.availability_zone[count.index % length(var.availability_zone)]

  tags = {
    Name                                          = "Public Subnet ${count.index + 1}"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.subnet.private_subnets)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet.private_subnets[count.index]
  availability_zone = var.availability_zone[count.index % length(var.availability_zone)]

  tags = {
    Name                                          = "Private Subnet ${count.index + 1}"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

### igw ###
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id  
  tags = {
    "Name" = "devops_igw"
  }
}

##### routing table #####
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id  
  tags = {
    "Name" = "public-rt"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id  
  tags = {
    "Name" = "private-rt"
  }
}

##### routing record #####
resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public-rt.id  
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id  
}

##### route table associate #####
resource "aws_route_table_association" "public" {
  count          = length(var.subnet.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.subnet.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private-rt.id
}

# outputs.tf
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id  
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id  
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public-rt.id
}

output "public_route" {
  description = "The public route information"
  value = {
    route_table_id = aws_route_table.public-rt.id
    gateway_id     = aws_internet_gateway.igw.id
  }
}