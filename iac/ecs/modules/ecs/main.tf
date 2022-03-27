# Create ECS Task Execution Role Data
data "aws_iam_policy_document" "ecs_task_execution_role" {
    version = "2012-10-17"
    statement {
        sid = ""
        effect = "Allow"
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ecs-tasks.amazonaws.com"]
        }
    }
}

# Create ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution_role" {
    name = "${var.name}-ecs-task-execution-role"
    assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

# Create ECS Task Execution Role Policy Attachmentment
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
    role = "${var.name}-ecs-task-execution-role"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Create a ECS Fargate Cluster
resource "aws_ecs_cluster" "ecs" {
    name = var.name
    capacity_providers = ["FARGATE"]

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
data "template_file" "cd_app" {
  template = file("./templates/ecs/container.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}

# Create a new task definition for the ECS Cluster
resource "aws_ecs_task_definition" "app" {
  family                   = "${var.name}-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.cc_app.rendered
}

resource "aws_ecs_service" "main" {
  name            = "${var.name}-service"
  cluster         = aws_ecs_cluster.ecs.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "cc-app"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}
