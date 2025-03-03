# IAM role for eks

resource "aws_iam_role" "devops" {
  name = "eks-cluster-devops"
  tags = {
    tag-key = "eks-cluster-devops"
  }

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

# eks policy attachment

resource "aws_iam_role_policy_attachment" "devops-AmazonEKSClusterPolicy" {
  role       = aws_iam_role.devops.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# bare minimum requirement of eks

resource "aws_eks_cluster" "devops" {
  name     = "devops"
  role_arn = aws_iam_role.devops.arn

  vpc_config {
    subnet_ids = [
#      aws_subnet.private-us-east-1a.id,
#      aws_subnet.private-us-east-1b.id,
#      aws_subnet.public-us-east-1a.id,
#      aws_subnet.public-us-east-1b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.devops-AmazonEKSClusterPolicy]
}
