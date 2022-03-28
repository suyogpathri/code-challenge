# Create ECS Task Execution Role Data
data "aws_iam_policy_document" "ecs_policy_document" {
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
    assume_role_policy = data.aws_iam_policy_document.ecs_policy_document.json
}

# Create ECS Task Execution Role Policy Attachmentment
resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
    role = "${var.name}-ecs-task-execution-role"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

    depends_on = [aws_iam_role.ecs_task_execution_role]
}