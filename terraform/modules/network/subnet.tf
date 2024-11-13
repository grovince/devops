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