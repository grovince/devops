resource "aws_eks_cluster" "grovince" {
    name = "grovince"
    vpc_config {
        security_group_ids = [aws_security_group.eks-sg.id]
        subnet_ids = [aws_subnet.grovince-public-01.id, aws_subnet.grovince-public-02.id]
        endpoint_public_access = true
    }
    depends_on = [ 
        aws_iam_role_policy_attachment.grovince-iam-policy-eks-cluster,
        aws_iam_role_policy_attachment.grovince-iam-policy-eks-cluster-vpc,
    ]
    role_arn = aws_iam_role.grovince-iam-eks-role-cluster.arn
    version = "1.28"

    enabled_cluster_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"] #cluster log
    
}