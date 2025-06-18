resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags       = { Name = var.vpc_name }
}

### public subnets
resource "aws_subnet" "public" {
  count = length(var.subnet_configs.public_subnets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_configs.public_subnets[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.vpc_name}-public-${count.index + 1}",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
    "kubernetes.io/role/elb"                      = "1"
  }
}

### private subnets
resource "aws_subnet" "private" {
  count = length(var.subnet_configs.private_subnets)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_configs.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  
  tags = {
    Name = "${var.vpc_name}-private-${count.index + 1}",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
    "kubernetes.io/role/internal-elb"             = "1"
  }
}