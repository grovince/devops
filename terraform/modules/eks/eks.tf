resource "aws_eks_cluster" "eks" {
  name     = "${var.cluster_name}-cluster"
  version  = var.eks_version
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids                   = var.subnet_ids
    endpoint_private_access      = true
    endpoint_public_access       = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}