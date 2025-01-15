# Calling the vpc module
module "vpc" {
  source = "../terraform/module/vpc"
}

# Calling the security Group module
module "security_groups" {
  source  = "../terraform/module/security_groups"
  vpc_id  = local.vpc_id
  subnets = local.subnets
}

# Calling the alb module
module "alb" {
  source          = "../terraform/module/alb"
  vpc_id          = local.vpc_id
  subnets         = local.subnets
  alb_sg_id       = local.alb_sg_id
  certificate_arn = local.certificate_arn
}

# Calling the iam module
module "iam" {
  source      = "../terraform/module/iam"
  region      = var.region
  aws_account = var.aws_account
}

# Calling the asg module
module "asg" {
  source                   = "../terraform/module/asg"
  vpc_id                   = local.vpc_id
  subnets                  = local.subnets
  ami_id                   = local.ami_id
  asg_sg_id                = local.asg_sg_id
  target_group_arn         = local.target_group_arn
  ec2_role_arn             = local.ec2_role_arn
  ec2_instance_profile_arn = local.ec2_instance_profile_arn
}

# Calling the cloud_watch module
module "cloud_watch" {
  source = "../terraform/module/cloud_watch"
}

# Calling the certificate module
module "certificate" {
  source       = "../terraform/module/certificate"
  alb_dns_name = local.alb_dns_name
  alb_zone_id  = local.alb_zone_id
  zone_id      = var.zone_id
  domain_name  = var.domain_name
}
