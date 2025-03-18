locals {
  vpc_name        = "devops-eks-vpc"
  cidr            = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24"]
  private_subnets = ["10.0.4.0/24"]
  azs             = ["ap-northeast-2a"]
  cluster_name    = "devops-eks-cluster"
}

resource "aws_vpc" "vpc" {
  cidr_block = local.cidr
  tags       = { Name = local.vpc_name }
}

### public subnets
resource "aws_subnet" "public" {
  count = length(local.public_subnets) # 여러개를 정의합니다

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.public_subnets[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true # 퍼플릭 서브넷에 배치되는 서비스는 자동으로 공개 IP를 부여합니다
  tags = {
    Name = "${local.vpc_name}-public-${count.index + 1}",
    "kubernetes.io/cluster/${local.cluster_name}" = "shared", # 다른 부분
    "kubernetes.io/role/elb"                      = "1" # 다른 부분
  }
}

### private subnets
resource "aws_subnet" "private" {
  count = length(local.private_subnets) # 여러개를 정의합니다

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = local.private_subnets[count.index]
  availability_zone = local.azs[count.index]
  tags = {
    Name = "${local.vpc_name}-private-${count.index + 1}",
    "kubernetes.io/cluster/${local.cluster_name}" = "shared", # 다른 부분
    "kubernetes.io/role/internal-elb"             = "1" # 다른 부분
  }
}