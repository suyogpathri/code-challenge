# Create a ECS Fargate Cluster
resource "aws_ecs_cluster" "ecs" {
    name = var.name

    setting {
        name = "containerInsights"
        value = "enabled"
    }
    tags = {
        Name = var.name
        Environment = var.environment
    }
}

# Container Task Definition Template
data "template_file" "cc_app" {
    template = file("${path.module}/templates/ecs/container.json")

    vars = {
        app_image = var.app_image
        app_port = var.container_port
        fargate_cpu = var.container_cpu
        fargate_memory = var.container_memory
        aws_region = var.region
        aws_log_group = var.log_group_name
    }
}

# Create a new task definition for the ECS Cluster
resource "aws_ecs_task_definition" "app" {
    family = "${var.name}-task"
    execution_role_arn = var.ecs_task_role_arn
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu = var.container_cpu
    memory  = var.container_memory
    container_definitions = data.template_file.cc_app.rendered
}

resource "aws_ecs_service" "main" {
  name = "${var.name}-service"
  cluster = aws_ecs_cluster.ecs.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count = var.app_count
  launch_type = "FARGATE"

  network_configuration {
    security_groups = [var.security_groups]
    subnets = var.private_subnets
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name = "cc-app"
    container_port = var.container_port
  }

  lifecycle {
    create_before_destroy = true
  }
}
