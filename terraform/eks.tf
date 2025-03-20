# EKS 클러스터 생성
resource "aws_eks_cluster" "devops" {
  name     = var.cluster_name
  role_arn = aws_iam_role.devops.arn
  version  = var.cluster_version

  vpc_config {
    security_group_ids = [aws_security_group.eks.id]
    subnet_ids         = aws_subnet.private.*.id
  }

  depends_on = [
    aws_iam_role_policy_attachment.devops-AmazonEKSClusterPolicy,
  ]
}

# EKS 노드 그룹 생성 (첫 번째 그룹)
resource "aws_eks_node_group" "one" {
  cluster_name    = aws_eks_cluster.devops.name
  node_group_name = var.node_group_one_name
  node_role_arn   = aws_iam_role.nodes.arn

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = [var.instance_type]

  subnet_ids     = aws_subnet.private.*.id

  depends_on     = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}

# EKS 노드 그룹 생성 (두 번째 그룹)
resource "aws_eks_node_group" "two" {
  cluster_name    = aws_eks_cluster.devops.name
  node_group_name = var.node_group_two_name
  node_role_arn   = aws_iam_role.nodes.arn

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = [var.instance_type]

  subnet_ids     = aws_subnet.private.*.id

  depends_on     = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}

# EBS CSI 드라이버 추가 구성
resource "aws_eks_addon" "ebs-csi" {
  cluster_name             = aws_eks_cluster.devops.name
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
  tags = {
    "eks_addon" = "ebs-csi"
    "terraform" = "true"
  }
}

