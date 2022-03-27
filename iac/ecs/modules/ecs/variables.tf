variable "name" {
    type = string
    description = "The name of the stack"
}

variable "environment" {
    type = string
    description = "The environment of the stack"
}

variable "region" {
    description = "the AWS region in which resources are created, you must set the availability_zones variable as well if you define this value to something other than the default"
    default = "us-east-1"
}

variable "vpc_id" {
    type = string
    description = "The VPC id to use"
}

variable "private_subnets" {
    type = list(string)
    description = "The value of the private subnet ids"
}

variable "security_groups" {
    type = string
    description = "The value of the security groups to be attached to ECS service."
}

variable "container_cpu" {
    type = number
    description = "The number of cpu units used by the task."
    default = 512
}
  
variable "container_memory" {
    type = number
    description = "The amount (in MiB) of memory used by the task."
    default = 1024
}

variable "app_image" {
    description = "Docker image to run in the ECS cluster"
    default     = "suyogpathri/cc-uat:latest"
}

variable "container_port" {
    description = "Port exposed by the docker image to redirect traffic to"
    default     = 5000
}

variable "app_count" {
    description = "Number of docker containers to run"
    default     = 1
}

variable "health_check_path" {
    default = "/"
}

variable "target_group_arn" {
    description = "The ARN of the target group"
    default = ""
}