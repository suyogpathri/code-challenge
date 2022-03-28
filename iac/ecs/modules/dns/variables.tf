variable "lb_dns_name" {
    description = "The application load balancer dns name"
    type = string
}

variable "zone_name" {
    description = "The route 53 dns zone name"
    type = string
}

variable "sub_domain" {
    description = "The application subdomain. e.g. app.example.com"
    type = string
}