##### routing table #####
resource "aws_route_table" "grovince-public-rt" {
    vpc_id = aws_vpc.grovince-vpc.id
    tags = {
      "Name" = "grovince-public-rt"
    }
}

resource "aws_route_table" "grovince-private-rt" {
    vpc_id = aws_vpc.grovince-vpc.id
    tags = {
      "Name" = "grovince-private-rt"
    }
}


##### routing recored #####
resource "aws_route" "grovince-public-route" {
    route_table_id = aws_route_table.grovince-public-rt.id

    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.grovince-igw.id
}


resource "aws_route" "grovince-private-route" {
    route_table_id = aws_route_table.grovince-private-rt.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.grovince-nat.id
}


##### route table associate #####
resource "aws_route_table_association" "grovince-public-rt-as-01" {
    subnet_id = aws_subnet.grovince-public-01.id
    route_table_id = aws_route_table.grovince-public-rt.id
}

resource "aws_route_table_association" "grovince-public-rt-as-02" {
    subnet_id = aws_subnet.grovince-public-02.id
    route_table_id = aws_route_table.grovince-public-rt.id
}

resource "aws_route_table_association" "grovince-private-rt-as-01" {
    subnet_id = aws_subnet.grovince-private-01.id
    route_table_id = aws_route_table.grovince-private-rt.id
}

resource "aws_route_table_association" "grovince-private-rt-as-02" {
    subnet_id = aws_subnet.grovince-private-02.id
    route_table_id = aws_route_table.grovince-private-rt.id
}