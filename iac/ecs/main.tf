# Create a new VPC
module "vpc_uat" {
    source = "./modules/vpc"

    vpc_cidr = "172.26.0.0/25"

    public_subnet_cidr = ["172.26.0.0/28", "172.26.0.16/28"]
    private_subnet_cidr = ["172.26.0.32/28", "172.26.0.48/28"]
    availability_zones = ["us-east-1d", "us-east-1c"]

    name = "${var.name}"
    environment = "${var.environment}"
}

# Create a security groups.
module "security_groups_uat"{
    source = "./modules/security_groups"
    
    alb_cidr = "0.0.0.0/0"
    vpc_id = module.vpc_uat.vpc_id
    http_port =80
    https_port = 443
    container_port = var.container_port

    name = "${var.name}"
    environment = "${var.environment}"
}

# Create a new Application Load Balancer
module "alb_uat" {
    source = "./modules/alb"

    availability_zones = ["us-east-1d", "us-east-1c"]
    vpc_id = module.vpc_uat.vpc_id
    public_subnets = "${module.vpc_uat.public_subnets}"
    tls_cert_arn = "${var.tls_cert_arn}"
    security_group_id = "${module.security_groups_uat.alb_security_group_id}"
    http_port =80
    https_port = 443
    delete_protection = var.alb_delete_protection
    internal = var.alb_internal_configuration
    enable_https2 = var.alb_enable_https2
    target_group_protocol = var.alb_target_group_protocol
    target_group_type = var.alb_target_group_type

    name = "${var.name}"
    environment = "${var.environment}"
}

# Create a Log group for CloudWatch
module "logs_uat" {
    source = "./modules/logs"
    name = "${var.name}"
    environment = "${var.environment}"
    retention_in_days = var.retention_in_days
}

module "role_uat" {
    source = "./modules/roles"
    name = "${var.name}"
    environment = "${var.environment}"
}

#Create a new ECS Cluster, Definiations, Services and Tasks for application
module "ecs_uat" {
    source = "./modules/ecs"

    vpc_id = module.vpc_uat.vpc_id
    private_subnets = "${module.vpc_uat.private_subnets}"
    security_groups = "${module.security_groups_uat.ecs_fargate_security_group_id}"
    log_group_name = "${module.logs_uat.log_group_name}"
    ecs_task_role_arn = "${module.role_uat.ecs_task_role_arn}"

    name = "${var.name}"
    environment = "${var.environment}"
    app_image = "${var.app_image}"
    container_cpu = var.container_cpu
    container_memory = var.container_memory
    container_port = var.container_port
    health_check_path = var.health_check_path
    target_group_arn = "${module.alb_uat.aws_lb_target_group_arn}"
}

# Create a Route53 record for the ALB
module "dns_uat" {
    source = "./modules/dns"
    lb_dns_name = "${module.alb_uat.aws_lb_dns}"
    sub_domain = "${var.sub_domain}"
    zone_name = "${var.zone_name}"
}