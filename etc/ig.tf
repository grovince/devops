resource "aws_internet_gateway" "grovince-igw" {
    vpc_id = aws_vpc.grovince-vpc.id
    tags = {
      "Name" = "grovince-igw"
    }
}