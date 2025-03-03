module "iam_eks_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-eks-role"

  role_name = "my-app"

  cluster_service_accounts = {
    "cluster1" = ["default:322084995268"]
  }
}