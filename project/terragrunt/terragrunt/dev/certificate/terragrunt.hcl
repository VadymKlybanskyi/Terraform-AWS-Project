# Main configuration block for Certificate module
terraform {
  source = "../../../modules/certificate"
}

# Include the root module configuration
include "root" {
  path = find_in_parent_folders()
}

# Dependency block for ALB module
dependency "alb" {
  config_path                             = "../alb"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs = {
    alb_dns_name = "fake-alb_dns_name"
    alb_zone_id  = "fake-alb_zone_id"
  }
}

# Input variables for the Certificate module
inputs = {
  alb_dns_name = dependency.alb.outputs.alb_dns_name
  alb_zone_id  = dependency.alb.outputs.alb_zone_id
}
