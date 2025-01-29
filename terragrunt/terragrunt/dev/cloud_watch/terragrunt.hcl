# Main configuration block for Cloud_Watch module
terraform {
  source = "../../../modules/cloud_watch"
}

# Include the root module configuration
include "root" {
  path = find_in_parent_folders()
}