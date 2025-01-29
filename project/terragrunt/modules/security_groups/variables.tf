variable "vpc_id" {
  description = "ID VPC"
  type        = string
}

variable "subnets" {
  description = "subnets list"
  type        = list(string)
}
