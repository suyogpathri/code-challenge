variable "name" {
    type = string
    description = "The name of the stack"
}

variable "environment" {
    type = string
    description = "The environment of the stack"
}

variable "retention_in_days" {
    type = number
    description = "The number of days to retain logs."
    default = 5
}