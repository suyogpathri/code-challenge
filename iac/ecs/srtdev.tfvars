# Basic Configuration
name                = "srt-dev-stack"
environment         = "srt-uat"
profile             = "srt-dev"

# VPC Configuration
availability_zones  = ["us-east-1d", "us-east-1c"]
cidr                = "172.26.0.0/25"
private_subnets     = ["172.26.0.32/28", "172.26.0.48/28"]
public_subnets      = ["172.26.0.0/28", "172.26.0.16/28"]
database_subnets    = ["172.26.0.64/28", "172.26.0.80/28"]


# ALB Configuration
tsl_certificate_ssm         = "wildcard.test.ielstage.com-ssm"
alb_delete_protection       = false
alb_internal_configuration  = false
alb_enable_https2           = true
alb_target_group_protocol   = "HTTP"
alb_target_group_type       = "ip"

# ECS Configuration
container_memory    = 1024
container_cpu       = 512
container_port      = 5000