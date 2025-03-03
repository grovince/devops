terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
<<<<<<< HEAD
      version = "~> 5.0"
=======
      version = "~> 4.0"
>>>>>>> 33f1e1ab8e577a656c255126f49cc095b9faf3ff
    }
  }
}

provider "aws" {
<<<<<<< HEAD
  region = var.region
}

module "network" {
  source              = "./modules/network"
}

module "eks" {
  source            = "./modules/eks"
=======
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