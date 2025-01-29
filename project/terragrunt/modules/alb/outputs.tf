# Output DNS name for Application Load Balancer (ALB)
output "alb_dns" {
  value = aws_lb.app.dns_name
}

# Output ARN for the Target Group associated with the ALB
output "target_group_arn" {
  value = aws_lb_target_group.app.arn
}

# Output DNS name and Zone ID from the ALB module
output "alb_dns_name" {
  value       = aws_lb.app.dns_name
  description = "The DNS name of the ALB"
}

output "alb_zone_id" {
  value       = aws_lb.app.zone_id
  description = "The Zone ID of the ALB"
}
