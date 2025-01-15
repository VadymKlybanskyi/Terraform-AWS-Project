# Create an SSL certificate through ACM (AWS Certificate Manager)
resource "aws_acm_certificate" "ssl_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  # Additional domains (alternative names)
  subject_alternative_names = [
    "www.${var.domain_name}"
  ]

  tags = {
    Environment = "dev"
  }
}

# Create DNS records for domain validation
resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.ssl_cert.domain_validation_options :
    dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.value]
  ttl     = 300
}

# Validate the certificate after creating DNS records
resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.ssl_cert.arn                            # Certificate ARN
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn] # Fully qualified domain names for validation
}

# Create an A-type DNS record for ALB (Application Load Balancer)
resource "aws_route53_record" "alb_record" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name # ALB DNS name
    zone_id                = var.alb_zone_id  # ALB Zone ID
    evaluate_target_health = true             # Evaluate target health
  }
}
