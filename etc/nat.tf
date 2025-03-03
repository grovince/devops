resource "aws_eip" "grovince-eip" {
    tags = {
      "Name" = "grovince-eip"
    }
}

resource "aws_nat_gateway" "grovince-nat" {
    allocation_id = aws_eip.grovince-eip.id # eip와 연결
    subnet_id = aws_subnet.grovince-public-01.id #public subnet 01에 연결
    tags = {
        "Name" = "grovince-nat"
    }
}