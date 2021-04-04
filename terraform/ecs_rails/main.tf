locals {
  account_id = data.aws_caller_identity.user.account_id
}

# ECSタスク実行ロールの作成
module "ecs_task_execution_role" {
  source     = "../iam_role"
  name       = "ecs-task-execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}

resource "aws_ecs_task_definition" "task_definition" {
  family = var.app_name

  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = data.template_file.container_definitions.rendered
  execution_role_arn    = module.ecs_task_execution_role.iam_role_arn

  volume {
    name = "tmp-data"
  }
}

resource "aws_cloudwatch_log_group" "log" {
  count = length(var.apps_name)
  name  = "/ecs/example/${var.apps_name[count.index]}"
}

