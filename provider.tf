# Configure Terraform settings and required providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"           # Use AWS provider version 4.16.x (latest patch)
    }
  }
  required_version = ">= 1.2.0"     # Minimum Terraform version required
}

provider "aws" {
  region  = "ap-northeast-1"      #choose the region thats allowed to your account
  profile = "default"
}