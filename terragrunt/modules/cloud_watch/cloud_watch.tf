# Create a log group for EC2 in CloudWatch
resource "aws_cloudwatch_log_group" "ec2_logs" {
  name              = "/dev/nginx" # Log group name
  retention_in_days = 1            # Log retention period (in days)
}
