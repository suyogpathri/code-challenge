output "alb_security_group_id" {
    value = "${aws_security_group.alb.id}"
    description = "The value of alb security group id"
}

output "ecs_fargate_security_group_id" {
    value = "${aws_security_group.ecs_fargate.id}"
    description = "The value of ECS Fargate security group id"
}