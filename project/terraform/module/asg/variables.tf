# Variables for ASG
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

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "List of subnets"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI identifier to be used for launching EC2 instances"
  type        = string
}

variable "asg_sg_id" {
  description = "Security Group ID to be used for the Auto Scaling Group"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the Target Group where EC2 instances will be added"
  type        = string
}

variable "ec2_role_arn" {
  description = "ARN of the Instance Profile to be assigned to EC2 instances"
  type        = string
}

variable "ec2_instance_profile_arn" {
  description = "ARN of the IAM Instance Profile to be attached to the Launch Template"
  type        = string
}
