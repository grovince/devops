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
