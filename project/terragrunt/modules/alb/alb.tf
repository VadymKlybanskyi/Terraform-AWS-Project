### Application Load Balancer (ALB)
# Resource to create an Application Load Balancer (ALB)
resource "aws_lb" "app" {
  name               = "${var.env}-${var.app_name}-alb"
  internal           = false           # Specifies that the ALB is public (not internal)
  load_balancer_type = "application"   # Type of load balancer
  security_groups    = [var.alb_sg_id] # Security Group for ALB
  subnets            = var.subnets     # Subnets where the ALB will be deployed

  tags = {
    Project     = "App"
    Owner       = "DevOps"
    Environment = "${var.env}"
    Custom_tag  = "Works like this"
  }
}

# Resource to create a Target Group for ALB
resource "aws_lb_target_group" "app" {
  name = "${var.env}-${var.app_name}-app-tg"

  port        = 80         # Port on which the ALB will forward traffic
  protocol    = "HTTP"     # Protocol to be used for routing
  vpc_id      = var.vpc_id # VPC where the Target Group will be located
  target_type = "instance" # Target type - EC2 instance

  # Health check settings for the Target Group
  health_check {
    interval            = 30        # Health check interval (in seconds)
    path                = "/health" # Path for health check
    port                = 80        # Port for the health check
    healthy_threshold   = 5         # Number of successful checks to consider the target healthy
    unhealthy_threshold = 2         # Number of failed checks to consider the target unhealthy
    timeout             = 5         # Response wait time (in seconds)
    protocol            = "HTTP"    # Protocol for health check
    matcher             = "200"     # Response code indicating health
  }
}

# Resource to create a listener for ALB for HTTP
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app.arn # ARN of ALB for listening
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301" # Redirect to HTTPS
    }
  }
}

# Resource to create a listener for ALB for HTTPS
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.app.arn # ARN of ALB for listening
  port              = "443"
  protocol          = "HTTPS"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: Not found"
      status_code  = "404"
    }
  }

  # Add SSL certificate through the "certificate_arn" attribute
  certificate_arn = var.certificate_arn
}

# Resource to create a listener rule for ALB
resource "aws_lb_listener_rule" "app_asg" {
  listener_arn = aws_lb_listener.https_listener.arn # Use the correct listener resource
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
