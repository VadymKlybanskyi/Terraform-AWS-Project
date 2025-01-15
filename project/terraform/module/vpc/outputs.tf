# Output the ID of the default VPC
output "vpc_id" {
  value = data.aws_vpc.default.id
}

# Output the IDs of the subnets belonging to the default VPC
output "subnets" {
  value = data.aws_subnets.default.ids
}

# Output the ID of the latest Ubuntu 24 AMI image
output "ami_id" {
  value = data.aws_ami.ami.id
}
