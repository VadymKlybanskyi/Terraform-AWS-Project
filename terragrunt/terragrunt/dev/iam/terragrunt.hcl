# Main configuration block for IAM module
terraform {
  source = "../../../modules/iam"
}

# Include the root module configuration
include "root" {
  path = find_in_parent_folders()
}

