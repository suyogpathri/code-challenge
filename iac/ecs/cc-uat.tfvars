# Basic Configuration
name                = "cc-uat-stack"
environment         = "cc-uat"
profile             = "default" # AWS Profile
region              = "us-east-1"

# VPC Configuration
availability_zones  = ["us-east-1d", "us-east-1c"]
cidr                = "172.26.0.0/25"
private_subnets     = ["172.26.0.32/28", "172.26.0.48/28"]
public_subnets      = ["172.26.0.0/28", "172.26.0.16/28"]


# ALB Configuration
tls_cert_arn                = "" # The SSL Certificate ARN
alb_delete_protection       = false
alb_internal_configuration  = false
alb_enable_https2           = true
alb_target_group_protocol   = "HTTP"
alb_target_group_type       = "ip"

# Logs
retention_in_days       = 5

# ECS Fargate Configuration
container_memory        = 1024
container_cpu           = 512
app_image               = "suyogpathri/cc-uat:latest"
container_port          = 80
app_count               = 1
health_check_path       = "/"

# Route 53 Configuration
sub_domain = "www" # The subdomain to be used for the Route 53 record
zone_name = "example.com" # The zone name to be used for the Route 53 record