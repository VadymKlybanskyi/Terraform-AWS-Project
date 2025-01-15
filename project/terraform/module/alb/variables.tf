# Variables for ALB
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

variable "alb_sg_id" {
  description = "Security Group ID for ALB"
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate"
  type        = string
}
