locals {
    node_group_name        = "${var.cluster_name}-node-group"
    iam_role_policy_prefix = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy"
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Terraform = "true"
      Project   = "${var.cluster_name}-project"
    }
  }
}

module "eks"{
    source = "terraform-aws-modules/eks/aws"

    cluster_name    = var.cluster_name
    cluster_version = var.cluster_version

    cluster_endpoint_public_access  = true

    vpc_id          = module.network.vpc_id
    subnet_ids      = module.network.public_subnet_ids

    eks_managed_node_group_defaults = {
        instance_types = ["t2.medium"]
    }

    eks_managed_node_groups = {
        node_group = {
            name           = "node-group-1"

            instance_types = ["t2.medium"]

            min_size     = 2
            max_size     = 4
            desired_size = 2
        } 
    }
    tags = local.tags
}