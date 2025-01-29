# Main configuration block for VPC module
terraform {
  source = "../../../modules/vpc"
}

# Include the root module configuration
include "root" {
  path = find_in_parent_folders()
}