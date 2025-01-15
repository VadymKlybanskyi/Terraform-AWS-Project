# Output the Security Group ID for the Auto Scaling Group (ASG)
output "asg_sg_id" {
  value = aws_security_group.asg_sg.id
}

# Output the Security Group ID for the Application Load Balancer (ALB)
output "alb_sg_id" {
  value = aws_security_group.alb.id
}
