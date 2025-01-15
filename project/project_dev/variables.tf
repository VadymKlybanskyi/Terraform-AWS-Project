# Define region
variable "region" {
  type        = string
  description = "AWS region"
}

# Define AWS account
variable "aws_account" {
  type        = string
  description = "AWS account"
}

# Define zone_id
variable "zone_id" {
  type        = string
  description = "Zone ID"
}

# Define domain name
variable "domain_name" {
  type        = string
  description = "domain name"
}
