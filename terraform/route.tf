### 퍼블릭 서브넷 라우팅 테이블 
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "${var.vpc_name}-public" }
}

### 퍼블릭 서브넷에서 인터넷에 트래픽 요청 시 앞서 정의한 IGW로 보냄
resource "aws_route" "public_worldwide" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

### 퍼블릭 서브넷에 라우팅 테이블 연결
resource "aws_route_table_association" "public" {
  count = length(var.subnet_configs.public_subnets)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

### 프라이빗 서브넷 라우팅 테이블
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "${var.vpc_name}-private" }
}

### 프라이빗 서브넷에 라우팅 테이블 연결 
resource "aws_route_table_association" "private" {
  count = length(var.subnet_configs.private_subnets)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

### 프라이빗 서브넷에서 인터넷 접속 시 사용할 NAT GW
resource "aws_route" "private_worldwide" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}
