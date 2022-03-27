variable "name" {
    type = string
    description = "The name of the stack"
}

variable "environment" {
    type = string
    description = "The environment of the stack"
}

variable "vpc_id" {
    type = string
    description = "The VPC id to use"
}

variable "private_subnets" {
    type = list(string)
    description = "The value of the private subnet ids"
}

variable "iam_role_arn" {
    type = string
    description = "The IAM role arn"
}

variable "fargate_cpu" {
    type = number
    description = "The number of cpu units used by the task."
    default = 512
}
  
variable "fargate_memory" {
    type = number
    description = "The amount (in MiB) of memory used by the task."
    default = 1024
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "suyogpathri/cc-uat:latest"
}

variable "app_port" {
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