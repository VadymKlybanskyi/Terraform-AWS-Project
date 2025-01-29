# Main configuration block for ALB module
terraform {
  source = "../../../modules/alb"
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

# Dependency block for Security Groups module
dependency "security_groups" {
  config_path                             = "../security_groups"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs = {
    alb_sg_id = "fake_security_group_id"
  }
}

# Dependency block for SSL module
dependency "ssl" {
  config_path                             = "../ssl"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs = {
    certificate_arn = "fake-certificate-arn"
  }
}

# Input variables for the ALB module
inputs = {
  vpc_id          = dependency.vpc.outputs.vpc_id
  subnets         = dependency.vpc.outputs.subnets
  alb_sg_id       = dependency.security_groups.outputs.alb_sg_id
  certificate_arn = dependency.ssl.outputs.certificate_arn
}
