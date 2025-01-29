# Variable to store the domain name associated with the Hosted Zone
variable "domain_name" {
  type        = string
  description = "The domain name associated with the Hosted Zone"
  default     = "tryandcry.pp.ua"
}

# Variable to store the Zone ID of the Hosted Zone (Route53)
variable "zone_id" {
  type        = string
  description = "The Zone ID of the Hosted Zone"
  default     = "Z00046261NVLLDWQGWA0R"
}
