# Setting up your AWS provider
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Application = "Sigma DevOps Course"
    }
  }
}

# Setting up Terraform
terraform {
  required_version = ">= 1.10.0"

  # Setting up a backend to store infrastructure status
  backend "s3" {
    bucket         = "dev-sigma-devops-terraform-state"
    key            = "dev/us-east-1/project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "global-sigma-devops-terraform-lock"
  }

  # Identify the necessary providers
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.82.2"
    }
  }
}
