#  Variables for ASG
variable "env" {
  description = "Environment for the resource"
  type        = string
  default     = "dev"
}

variable "app_name" {
  description = "application name "
  type        = string
  default     = "app"
}

variable "vpc_id" {
  description = "ID VPC"
  type        = string
}

variable "subnets" {
  description = "Список підмереж"
  type        = list(string)
}

variable "ami_id" {
  description = "Ідентифікатор AMI, який буде використовуватись для запуску EC2 інстансів"
  type        = string
}

variable "asg_sg_id" {
  description = "Ідентифікатор Security Group, який буде використано для Auto Scaling Group"
  type        = string
}

variable "target_group_arn" {
  description = "ARN для Target Group, до якого будуть додаватись EC2 інстанси"
  type        = string
}

variable "ec2_role_arn" {
  description = "ARN для Instance Profile, який буде призначено EC2 інстансам"
  type        = string
}

variable "ec2_instance_profile_arn" {
  description = "ARN IAM Instance Profile для прив’язки до Launch Template"
  type        = string
}
