output "ecs_arn"{
    value = "${aws_ecs_cluster.ecs.arn}"
}

output "ecs_id"{
    value = "${aws_ecs_cluster.ecs.id}"
}

output "alb_host_name" {
  value = "${aws_alb.main.dns_name}"
}