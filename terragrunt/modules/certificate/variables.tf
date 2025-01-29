# Variable to store the DNS name of the ALB (Application Load Balancer)
variable "alb_dns_name" {
  type        = string
  description = "The DNS name of the ALB"
}

# Variable to store the Zone ID of the ALB (Application Load Balancer)
variable "alb_zone_id" {
  type        = string
  description = "The Zone ID of the ALB"
}

# Variable to store the Zone ID of the Hosted Zone (Route53)
variable "zone_id" {
  type        = string
  description = "The Zone ID of the Hosted Zone"
  default     = "Z00046261NVLLDWQGWA0R"
}

# Variable to store the domain name associated with the Hosted Zone
variable "domain_name" {
  type        = string
  description = "The domain name associated with the Hosted Zone"
  default     = "tryandcry.pp.ua"
}
