<<<<<<< HEAD
### Internet Gateway ###
=======
>>>>>>> 33f1e1ab8e577a656c255126f49cc095b9faf3ff
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.cluster_name}-igw"
  }
}