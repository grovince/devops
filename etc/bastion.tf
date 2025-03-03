resource "aws_eip" "bastion-eip" { #퍼블릭 ip 할당
    tags = {
      "Name" = "bastion-eip"
    }
}

resource "aws_instance" "bastion-host" { #bastion host생성
    ami = "ami-04ab8d3a67dfe6398" #Amazon Linux AMI ID
    instance_type = "t2.micro"
    key_name = "test"
    vpc_security_group_ids = [aws_default_security_group.grovince-default.id, aws_security_group.grovince-sg-ssh.id]
    subnet_id = aws_subnet.grovince-public-01.id
    associate_public_ip_address = "true" #bation host에 public ip를 붙임
    root_block_device { #스토리지 설정
      volume_size = "10" 
      volume_type = "gp3"
      tags = { #볼륨 태그
        "Name" = "bastion-host"
      }
    }
    tags = {
      "Name" = "bastion-host"
    }
}

resource "aws_eip_association" "bastion-eip-associate" {
    instance_id = aws_instance.bastion-host.id
    allocation_id = aws_eip.bastion-eip.id
  
}