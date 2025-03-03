### security ###
resource "aws_security_group" "eks_security" {
  name   = "${var.cluster_name}-cluster-sg"
  vpc_id = module.network.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.route_cidr.cidr]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.route_cidr.cidr]
  }
  tags = {
    Name = "${var.cluster_name}-cluster-sg"
  }
}