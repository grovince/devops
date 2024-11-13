terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
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
}