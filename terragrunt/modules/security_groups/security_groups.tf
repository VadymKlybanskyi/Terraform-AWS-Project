# --Security groups

# Auto Scaling Group (ASG) SG
resource "aws_security_group" "asg_sg" {
  name        = "dev_app-asg_sg"
  description = "Allow TLS inbound traffic and all outbound traffic" # Inbound TLS traffic and all outbound traffic
  vpc_id      = var.vpc_id                                           # VPC ID for asg_sg

  tags = {
    Name = "dev_app-asg_sg"
  }
}

# Inbound rule for ASG SG, allowing traffic from ALB
resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id            = aws_security_group.asg_sg.id # ASG security group
  referenced_security_group_id = aws_security_group.alb.id    # ALB security group, from which inbound traffic is allowed
  ip_protocol                  = "-1"                         # Allows all protocols
}

# Outbound rule for ASG SG, allowing all traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.asg_sg.id
  cidr_ipv4         = "0.0.0.0/0" # Outbound traffic allowed to all addresses
  ip_protocol       = "-1"
}

# Application Load Balancer (ALB) SG
resource "aws_security_group" "alb" {
  name        = "dev_app-alb_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "dev_app-alb_sg"
  }
}

# Inbound rule for ALB, allowing HTTPS traffic
resource "aws_vpc_security_group_ingress_rule" "alb_https_ipv4" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0" # Allows traffic from all addresses
  from_port         = 443         # Port for HTTPS
  ip_protocol       = "tcp"       # TCP protocol
  to_port           = 443         # Port for HTTPS
}

# Inbound rule for ALB, allowing HTTP traffic
resource "aws_vpc_security_group_ingress_rule" "alb_http_ipv4" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "alb_all_traffic_ipv4" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # Semantically equivalent to all ports
}
