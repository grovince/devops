##### tcp 22번 적용 #####
resource "aws_security_group" "grovince-sg-ssh" { #bastion host를 위한 22번 포트 오픈
    name = "grovince-sg-ssh"
    description = "for ssh"
    vpc_id = aws_vpc.grovince-vpc.id
    tags = {
      "Name" = "grovince-sg-ssh"
    }
}

resource "aws_security_group_rule" "grovince-sg-ssh-ingress" { #인바운드 규칙
    security_group_id = aws_security_group.grovince-sg-ssh.id
    type = "ingress"
    description = "allow ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
}

resource "aws_vpc_security_group_egress_rule" "grovince-sg-ssh-egress" { #아웃바운드 규칙
    security_group_id = aws_security_group.grovince-sg-ssh.id
    description = "allow all outbound"
    ip_protocol = "-1" #form_port, to_prot 모두 0으로 설정
    cidr_ipv4 = "0.0.0.0/0"
}




##### TCP 80, 443 적용 #####
resource "aws_security_group" "grovince-https" {
    name = "grovince-https"
    description = "for https(s)"
    vpc_id = aws_vpc.grovince-vpc.id
    tags = {
      "Name" = "grovince-https"
    }
}

resource "aws_vpc_security_group_ingress_rule" "grovince-https-80" {
    description = "for http"
    security_group_id = aws_security_group.grovince-https.id
    ip_protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "grovince-https-443" {
    description = "for http"
    security_group_id = aws_security_group.grovince-https.id
    ip_protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "grovince-https" { #아웃바운드
    description = "allow all outbound"
    security_group_id = aws_security_group.grovince-https.id
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}





#######################################
############### eks sg  ###############

resource "aws_security_group" "eks-sg" {
    name = "eks-sg"
    description = "for eks"
    vpc_id = aws_vpc.grovince-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "eks-sg-ingress" {
    security_group_id = aws_security_group.eks-sg.id
    description = "allow all for eks"
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "eks-sg-egress" {
    security_group_id = aws_security_group.eks-sg.id
    description = "allow all for eks"
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}