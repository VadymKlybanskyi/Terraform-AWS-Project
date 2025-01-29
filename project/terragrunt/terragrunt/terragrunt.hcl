# Generate backend.tf file with remote state configuration
remote_state {
  backend = "s3"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket         = "dev-sigma-devops-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "global-sigma-devops-terraform-lock"
  }
}

# Generate an AWS provider configuration
generate "provider" {
  path      = "_provider.tf"
  if_exists = "overwrite"

  contents = <<EOF
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Application = "Sigma DevOps Course"
    }
  }
}

variable "aws_region" {
  description = "AWS Region."
} 

EOF
}

# Define local variables used in the configuration
locals {
  aws_region  = "us-east-1"
  zone_id     = "Z0689650D2YHOF4M5LGQ"
  domain_name = "tryandcry.pp.ua"
}

# Input variables passed to modules or resources
inputs = {
  aws_region  = local.aws_region
  zone_id     = local.zone_id
  domain_name = local.domain_name
}