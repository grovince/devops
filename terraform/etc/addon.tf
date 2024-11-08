resource "aws_eks_addon" "ebs-csi" {
    cluster_name = aws_eks_cluster.grovince.name
    # cluster_name = "grovince"
    addon_name = "aws-ebs-csi-driver"
    addon_version = "v1.26.1-eksbuild.1" #명령어를 통해 확인한 addon 버전

}
