### vpc 생성 시 기본으로 생성되는 보안 그룹
resource "aws_default_security_group" "default_sg" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "${var.vpc_name}-default" }
}

resource "aws_security_group" "eks" {
  name        = "eks-cluster-sg"
  description = "EKS Cluster Security Group"
  vpc_id      = aws_vpc.vpc.id

  # EKS 클러스터와 노드 간 통신을 허용
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  # 외부에서 클러스터에 접근할 수 있도록 허용
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "eks_cluster" = "true"
  }
}
