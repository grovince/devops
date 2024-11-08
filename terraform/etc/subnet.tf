resource "aws_subnet" "grovince-public-01" { #name : 테라폼이 관리하는 리소스의 이름
    vpc_id = aws_vpc.grovince-vpc.id #grovince_vpc ID를 사용
    cidr_block = "10.100.0.0/24"
    availability_zone = "ap-northeast-2a" #가용 영역
    map_public_ip_on_launch = "true" #퍼블릭 IP 할당 여부
    tags = {
      "Name" = "grovince-public-01"
      "kubernetes.io/cluster/grovince" = "shared"
      "kubernetes.io/role/elb" = 1
    }
}

resource "aws_subnet" "grovince-public-02" { #name : 테라폼이 관리하는 리소스의 이름
    vpc_id = aws_vpc.grovince-vpc.id #grovince_vpc ID를 사용
    cidr_block = "10.100.1.0/24"
    availability_zone = "ap-northeast-2c" #가용 영역
    map_public_ip_on_launch = "true" #퍼블릭 IP 할당 여부
    tags = {
      "Name" = "grovince-public-01"
      "kubernetes.io/cluster/grovince" = "shared"
      "kubernetes.io/role/elb" = 1
    }   
}


resource "aws_subnet" "grovince-private-01" { #name : 테라폼이 관리하는 리소스의 이름
    vpc_id = aws_vpc.grovince-vpc.id #grovince_vpc ID를 사용
    cidr_block = "10.100.2.0/24"
    availability_zone = "ap-northeast-2a" #가용 영역
    tags = {
      "Name" = "grovince-private-01"
    }
}

resource "aws_subnet" "grovince-private-02" { #name : 테라폼이 관리하는 리소스의 이름
    vpc_id = aws_vpc.grovince-vpc.id #grovince_vpc ID를 사용
    cidr_block = "10.100.3.0/24"
    availability_zone = "ap-northeast-2c" #가용 영역
    tags = {
      "Name" = "grovince-private-02"
    }
}
