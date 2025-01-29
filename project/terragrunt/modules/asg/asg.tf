### Auto Scaling groups (ASG)

resource "aws_launch_template" "app" {
  name                   = "${var.env}-${var.app_name}"
  image_id               = var.ami_id         # AMI for EC2 instances
  instance_type          = "t2.micro"         # EC2 instance type
  vpc_security_group_ids = [var.asg_sg_id]    # Security Group for instances
  key_name               = "SSH-key-Virginia" # SSH key

  # IAM role for access to AWS resources
  iam_instance_profile {
    arn = var.ec2_instance_profile_arn
  }

  # Disk configuration
  block_device_mappings {
    device_name = "/dev/xvda"
    no_device   = 0
    ebs {
      delete_on_termination = true
      encrypted             = false
      volume_size           = 15
      volume_type           = "gp3"
    }
  }

  # Додавання user_data (запуск docker compose з IAM роль)
  user_data = base64encode(<<-EOF
  #!/bin/bash

  cd /home/ubuntu/
  sudo docker-compose up -d

  EOF
  )

  # Create a new resource before destroying the old one
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app" {
  name = "${var.env}-${var.app_name}"
  # Desired, minimum, and maximum instance count
  desired_capacity          = 1
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"

  vpc_zone_identifier = var.subnets            # Subnets for launching instances
  target_group_arns   = [var.target_group_arn] # Bind ASG to Target Group

  # Bind to Launch Template
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  # Tags for instances
  tag {
    key                 = "Terraform"
    value               = "True"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "${var.env}-${var.app_name}"
    propagate_at_launch = true
  }
}
