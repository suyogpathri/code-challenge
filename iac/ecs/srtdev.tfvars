# Basic Configuration
name                = "cc-uat-stack"
environment         = "cc-uat"
profile             = "srt-dev"

# VPC Configuration
availability_zones  = ["us-east-1d", "us-east-1c"]
cidr                = "172.26.0.0/25"
private_subnets     = ["172.26.0.32/28", "172.26.0.48/28"]
public_subnets      = ["172.26.0.0/28", "172.26.0.16/28"]


# ALB Configuration
tsl_certificate_ssm         = "wildcard.test.ielstage.com-ssm"
alb_delete_protection       = false
alb_internal_configuration  = false
alb_enable_https2           = true
alb_target_group_protocol   = "HTTP"
alb_target_group_type       = "ip"

# ECS Fargate Configuration
fargate_memory   = 1024
fargate_cpu      = 512
app_image        = "docker pull suyogpathri/cc-uat:latest"
app_port         = 5000
app_count        = 1