# Output value for IAM Role
output "ec2_role_arn" {
  value       = aws_iam_role.ec2_role.arn
  description = "The ARN of the EC2 Role"
}

# Output value for IAM Instance Profile
output "ec2_instance_profile_name" {
  value       = aws_iam_instance_profile.ec2_instance_profile.name
  description = "The name of the IAM Instance Profile"
}

# Output value for ARN of IAM Instance Profile
output "ec2_instance_profile_arn" {
  value       = aws_iam_instance_profile.ec2_instance_profile.arn
  description = "The ARN of the IAM Instance Profile"
}
