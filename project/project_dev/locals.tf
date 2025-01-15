# Local variables for accessing source data
locals {
  vpc_id                   = module.vpc.vpc_id
  subnets                  = module.vpc.subnets
  ami_id                   = module.vpc.ami_id
  alb_sg_id                = module.security_groups.alb_sg_id
  asg_sg_id                = module.security_groups.asg_sg_id
  target_group_arn         = module.alb.target_group_arn
  alb_dns_name             = module.alb.alb_dns_name
  alb_zone_id              = module.alb.alb_zone_id
  ec2_role_arn             = module.iam.ec2_role_arn
  ec2_instance_profile_arn = module.iam.ec2_instance_profile_arn
  certificate_arn          = module.certificate.certificate_arn
}
