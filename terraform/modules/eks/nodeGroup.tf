resource "aws_eks_node_group" "node_group" {
    cluster_name    = aws_eks_cluster.eks.name
    node_group_name = "${var.cluster_name}-node-group"
    node_role_arn   = aws_iam_role.eks_node_role.arn
    subnet_ids      = var.subnet_ids

    scaling_config {
        desired_size = var.node_group_config.desired_size
        max_size     = var.node_group_config.max_size
        min_size     = var.node_group_config.min_size
    }

    instance_types = var.node_group_config.instance_types

    depends_on = [
        aws_iam_role_policy_attachment.eks_worker_node_policy,
        aws_iam_role_policy_attachment.eks_cni_policy,
        aws_iam_role_policy_attachment.ecr_read_only,
    ]
}
