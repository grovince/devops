<<<<<<< HEAD
### subnet ###
resource "aws_subnet" "public" {
  count             = length(var.subnet_configs.public_subnets)
  vpc_id            = aws_vpc.vpc.id  
  cidr_block        = var.subnet_configs.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]

  tags = {
    Name                                                = "Public Subnet ${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}"         = "shared"
    "kubernetes.io/role/elb"                            = "1"
=======
resource "aws_subnet" "public" {
  count                   = length(var.subnet_configs.public_subnets)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_configs.public_subnets[count.index]
  availability_zone       = var.availability_zones[count.index % length(var.availability_zones)]
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "Public Subnet ${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
>>>>>>> 33f1e1ab8e577a656c255126f49cc095b9faf3ff
  }
}

resource "aws_subnet" "private" {
  count             = length(var.subnet_configs.private_subnets)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_configs.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index % length(var.availability_zones)]

  tags = {
<<<<<<< HEAD
    Name                                                = "Private Subnet ${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}"         = "shared"
    "kubernetes.io/role/internal-elb"                   = "1"
  }
}
=======
    Name                                        = "Private Subnet ${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}
>>>>>>> 33f1e1ab8e577a656c255126f49cc095b9faf3ff
