# Main configuration block for SG module
terraform {
  source = "../../../modules/security_groups"
}

# Include the root module configuration
include "root" {
  path = find_in_parent_folders()
}

# Dependency block for VPC module
dependency "vpc" {
  config_path                             = "../vpc"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs = {
    vpc_id  = "fake-vpc-id"
    subnets = ["fake_subnet_ids"]
  }
}

# Input variables for the SG module
inputs = {
  vpc_id  = dependency.vpc.outputs.vpc_id
  subnets = dependency.vpc.outputs.subnets
}