resource "aws_eks_node_group" "grovince-eks-nodegroup" {
    cluster_name = "grovince"
    node_group_name = "groivnce-eks-nodegroup"
    node_role_arn = aws_iam_role.grovince-iam-eks-role-node-group.arn
    subnet_ids = [aws_subnet.grovince-public-01.id, aws_subnet.grovince-public-02.id] #나중에 다시 할때는 private에 배치하는 걸 권장
    instance_types = ["t3.medium"]
    disk_size = "20"

    scaling_config { #node 갯수
        desired_size = 2
        max_size     = 5
        min_size     = 2
    }

    depends_on = [ #정책 연결
        aws_iam_role_policy_attachment.grovince-iam-policy-eks-nodegroup,
        aws_iam_role_policy_attachment.grovince-iam-policy-eks-nodegroup-cni,
        aws_iam_role_policy_attachment.grovince-iam-policy-eks-nodegroup-ecr,
    ]

    tags = {
        "Name" = "grovince-worker-nodes"
    }
}