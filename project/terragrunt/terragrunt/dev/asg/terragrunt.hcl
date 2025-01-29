# Main configuration block for ASG module
terraform {
  source = "../../../modules/asg"
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
    ami_id  = "fake-imi_id"
  }
}

# Dependency block for Security Groups module
dependency "security_groups" {
  config_path                             = "../security_groups"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs = {
    asg_sg_id = "fake_security_group_id"
  }
}

# Dependency block for IAM module
dependency "iam" {
  config_path                             = "../iam"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs = {
    ec2_role_arn             = "fake_ec2_role_arn"
    ec2_instance_profile_arn = "fake_ec2_instance_profile_arn"
  }
}

# Dependency block for ALB module
dependency "alb" {
  config_path                             = "../alb"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs = {
    target_group_arn = "fake_target_group_arn"
  }
}


# Input variables for the ASG module
inputs = {
  vpc_id                   = dependency.vpc.outputs.vpc_id
  subnets                  = dependency.vpc.outputs.subnets
  ami_id                   = dependency.vpc.outputs.ami_id
  asg_sg_id                = dependency.security_groups.outputs.asg_sg_id
  target_group_arn         = dependency.alb.outputs.target_group_arn
  ec2_role_arn             = dependency.iam.outputs.ec2_role_arn
  ec2_instance_profile_arn = dependency.iam.outputs.ec2_instance_profile_arn

}

    