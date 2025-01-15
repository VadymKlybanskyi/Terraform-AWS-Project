# Getting information about the default VPC
data "aws_vpc" "default" {
  default = true
}

# Getting information about subnets of the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Getting the AMIs created using Packer
data "aws_ami" "ami" {
  most_recent = true
  owners      = ["self"] # AMIs created by your account

  # Filter to search AMIs by name
  filter {
    name   = "tag:Name"
    values = ["packer-dev-v1.0.*"]
  }
}

/*
# Search for the latest available AMI image for Ubuntu 24 to create EC2 instances
data "aws_ami" "ami" {
  most_recent = true
  owners      = ["099720109477"]

  # Filter to search AMIs by name
  filter {
    name   = "name"
    values = ["*ubuntu*24*-amd64-server-*"]
  }

  # Filter for virtualization type
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
*/

data "aws_region" "current" {}          # Getting information about the current AWS region
data "aws_caller_identity" "current" {} # Getting information about the current AWS user

# Local variables
locals {
  region      = data.aws_region.current.name
  aws_account = data.aws_caller_identity.current.account_id
}
