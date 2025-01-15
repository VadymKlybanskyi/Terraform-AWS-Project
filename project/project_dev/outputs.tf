###---VPC---###
# Output ID of the default VPC
output "vpc_id" {
  value = module.vpc.vpc_id
}
# Output IDs of the subnets belonging to the default VPC
output "subnets" {
  value = module.vpc.subnets
}
# Output ID of the latest Ubuntu 24 AMI image
output "ami_id" {
  value = module.vpc.ami_id
}

#------------------------------------------
###---Security Group---###
# Output ID of the Security Group for the Auto Scaling Group (ASG)
output "asg_sg_id" {
  value = module.security_groups.asg_sg_id
}

# Output ID of the Security Group for the Application Load Balancer (ALB)
output "alb_sg_id" {
  value = module.security_groups.alb_sg_id
}

#------------------------------------------
###---Application Load Balancer (ALB)---###
# Output DNS name for the Application Load Balancer (ALB)
output "alb_dns" {
  value = module.alb.alb_dns
}

# Output ARN for the Target Group associated with the ALB
output "target_group_arn" {
  value = module.alb.target_group_arn
}

# Output DNS name and Zone ID from the ALB module
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "alb_zone_id" {
  value = module.alb.alb_zone_id
}

#------------------------------------------
###---Identity and Access Management (IAM)---###
# Output ARN of the IAM role for EC2
output "ec2_role_arn" {
  value = module.iam.ec2_role_arn
}
# Output ARN of the IAM Instance Profile
output "ec2_instance_profile_arn" {
  value = module.iam.ec2_instance_profile_arn
}

#------------------------------------------
###---AWS Certificate Manager (ACM)---###
# Define output variable for the ARN of the SSL certificate
output "certificate_arn" {
  value = module.certificate.certificate_arn
}
