### IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "${var.vpc_name}-igw" }
}

### NAT GW의 고정 IP
resource "aws_eip" "nat_gateway_ip" {
  vpc  = true
  tags = { Name = "${var.vpc_name}-natgw" }
}

### 
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gateway_ip.id
  subnet_id     = aws_subnet.public[0].id # NAT 게이트웨이 자체는 퍼플릭 서브넷에 위치해야 합니다
  tags          = { Name = "${var.vpc_name}-natgw" }
}