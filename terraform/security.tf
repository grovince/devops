### vpc 생성 시 기본으로 생성되는 보안 그룹
resource "aws_default_security_group" "default_sg" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "${local.vpc_name}-default" }
}