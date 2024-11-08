############### EKS cluster IAM ########################

resource "aws_iam_role" "grovince-iam-eks-role-cluster" {
   name = "grovince-iam-eks-role-cluster"

   assume_role_policy = <<POLICY
{
"Version": "2012-10-17",
"Statement": [
   {
   "Action": "sts:AssumeRole",
   "Principal": {
      "Service": "eks.amazonaws.com"
   },
   "Effect": "Allow",
   "Sid": ""
   }
]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "grovince-iam-policy-eks-cluster"{
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
   role = aws_iam_role.grovince-iam-eks-role-cluster.name
}

resource "aws_iam_role_policy_attachment" "grovince-iam-policy-eks-cluster-vpc" {
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
   role = aws_iam_role.grovince-iam-eks-role-cluster.name
}

############### EKS NodeGroup IAM ########################

resource "aws_iam_role" "grovince-iam-eks-role-node-group" {
  name = "grovince-eks-iam-role-node-group"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY 
}

resource "aws_iam_role_policy_attachment" "grovince-iam-policy-eks-nodegroup" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.grovince-iam-eks-role-node-group.name
}

resource "aws_iam_role_policy_attachment" "grovince-iam-policy-eks-nodegroup-cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.grovince-iam-eks-role-node-group.name
}

resource "aws_iam_role_policy_attachment" "grovince-iam-policy-eks-nodegroup-ecr" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.grovince-iam-eks-role-node-group.name
}


resource "aws_iam_role_policy_attachment" "ebs-csi" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    role = aws_iam_role.grovince-iam-eks-role-node-group.name
}