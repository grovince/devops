terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    region = "ap-northeast-2"
  }

  module "network" {
    source = "./modules/network"
  }

  module "eks" {
    source = "./modules/eks"
  }

  module "IAM" {
    source = "./modules/IAM"
  >>>>>>> 33f1e1ab8e577a656c255126f49cc095b9faf3ff
  }
}