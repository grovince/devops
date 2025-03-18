terraform {
  required_version = "~> 1.3"

  cloud {
    workspaces {
      name = "devops-terraform-eks"
    }
  }
}