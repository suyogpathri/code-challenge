# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "log_group" {
    name  = "${var.name}-group"
    retention_in_days = var.retention_in_days

    tags = {
        name = "${var.name}-group"
        environment = var.environment
    }
}

resource "aws_cloudwatch_log_stream" "log_stream" {
    name  = "${var.name}-stream"
    log_group_name = aws_cloudwatch_log_group.log_group.name
}