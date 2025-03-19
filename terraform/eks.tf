module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.33.1"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                         = aws_vpc.vpc.id
  subnet_ids                     = aws_subnet.private.*.id
  
  cluster_endpoint_private_access = false
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    one = {
      name = var.node_group_one_name

      instance_types = [var.instance_type]

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size
    }

    two = {
      name = var.node_group_two_name

      instance_types = [var.instance_type]

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size
    }
  }
}