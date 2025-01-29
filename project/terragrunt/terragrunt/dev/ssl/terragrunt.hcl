# Main configuration block for SSL module
terraform {
  source = "../../../modules/ssl"
}

# Include the root module configuration
include "root" {
  path = find_in_parent_folders()
}
