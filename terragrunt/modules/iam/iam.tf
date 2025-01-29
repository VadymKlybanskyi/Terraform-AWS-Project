# IAM policy to allow EC2 to interact with CloudWatch
resource "aws_iam_policy" "cloudwatch_policy" {
  name        = "${var.env}-${var.app_name}-cloudwatch-logs-policy" # Policy name
  description = "Policy to allow EC2 to send logs to CloudWatch"    # Policy description
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow" # Action allowed
        Action = [
          "logs:CreateLogStream",   # Create log stream
          "logs:PutLogEvents",      # Put log events
          "logs:DescribeLogGroups", # Describe log groups
          "logs:DescribeLogStreams" # Describe log streams
        ]
        Resource = "*" # Access allowed to all resources
      }
    ]
  })
}

# IAM role for EC2 allowing it to assume the role through the policy
resource "aws_iam_role" "ec2_role" {
  name = "${var.env}-${var.app_name}-ec2-role" # Role name
  path = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" # Allow EC2 to assume the role
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the policy to the EC2 role
resource "aws_iam_role_policy_attachment" "ec2_cloudwatch_attachment" {
  role       = aws_iam_role.ec2_role.name           # Role to which the policy is attached
  policy_arn = aws_iam_policy.cloudwatch_policy.arn # ARN of the CloudWatch policy
}

# Create an EC2 instance profile that will use the role
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.env}-${var.app_name}-ec2-instance-profile" # Profile name
  role = aws_iam_role.ec2_role.name                        # Role that EC2 will use
}
