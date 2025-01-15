# Variables for IAM
variable "env" {
  description = "Environment for the resource"
  type        = string
  default     = "dev"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "app"
}

# Define the region
variable "region" {
  type        = string
  description = "AWS region"
}

# Define AWS account
variable "aws_account" {
  type        = string
  description = "AWS account"
}
