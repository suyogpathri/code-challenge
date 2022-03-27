variable "name" {
    description = "the name of your stack, e.g. \"demo\""
}

variable "environment" {
    description = "the name of your environment, e.g. \"prod\""
    default = "prod"
}

variable "region" {
    description = "the AWS region in which resources are created, you must set the availability_zones variable as well if you define this value to something other than the default"
    default = "us-east-1"
}

variable "profile" {
    description = "the name of the AWS profile to use, e.g. \"my-profile\""
    default = "default"
}

variable "availability_zones" {
    description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
    default = ["us-east-1d", "us-east-1c"]
}

variable "cidr" {
    description = "The CIDR block for the VPC."
    default = "10.0.0.0/16"
}

variable "private_subnets" {
    description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
    default = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]
}

variable "public_subnets" {
    description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
    default = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]
}

variable "service_desired_count" {
    description = "Number of tasks running in parallel"
    default = 1
}

variable "container_port" {
    description = "The port where the Docker is exposed"
    default = 8000
}

variable "container_cpu" {
    description = "The number of cpu units used by the task"
    default = 256
}

variable "container_memory" {
    description = "The amount (in MiB) of memory used by the task"
    default = 512
}

variable "health_check_path" {
    description = "Http path for task health check"
    default = "/health"
}

variable "tsl_certificate_ssm" {
    description = "The ARN of the certificate that the ALB uses for https"
}

variable "alb_delete_protection" { 
    description = "The ALB delete protection value."
}

variable "alb_internal_configuration" { 
    description = "ALB Configuration internal or external"
}

variable "alb_enable_https2" { 
    description = "Enable the HTTPS2 protocol on the ALB."
}

variable "alb_target_group_protocol" {
    description = "The ABL target group protocol"
}

variable "alb_target_group_type" {
    description = "The target group type IP/Instance"
}

variable "app_image" {
    description = "Docker image to run in the ECS cluster"
    default     = "suyogpathri/cc-uat:latest"
}

variable "app_count" {
    description = "Number of docker containers to run"
    default     = 1
}