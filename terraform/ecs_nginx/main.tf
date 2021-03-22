locals {
  name = "rails-hello-nginx"
}

resource "aws_ecs_task_definition" "task_definition" {
  family = local.name

  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = data.template_file.container_definitions.rendered
  execution_role_arn    = module.ecs_task_execution_role.iam_role_arn
}

resource "aws_lb_target_group" "target_group" {
  name = local.name

  vpc_id = var.vpc_id

  # ALBからECSタスクのコンテナへトラフィックを振り分ける設定
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"

  # コンテナへの死活監視設定
  health_check {
    port = 80
    path = "/"
  }
}

resource "aws_lb_listener_rule" "rule" {
  listener_arn = var.http_listener_arn

  # 受け取ったトラフィックをターゲットグループへ受け渡す
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.id
  }

  # ターゲットグループへ受け渡すトラフィックの条件
  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

resource "aws_cloudwatch_log_group" "for_ecs" {
  name              = "/ecs/example/${local.name}"
  retention_in_days = 180
}

resource "aws_security_group" "ecs_security_group" {
  name        = "${local.name}-sg"
  description = "security group of rails-hello-nginx ecs"

  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.name
  }
}

resource "aws_security_group_rule" "ingress_rule" {
  security_group_id = aws_security_group.ecs_security_group.id
  type              = "ingress"

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# ECSタスク実行ロールの作成
module "ecs_task_execution_role" {
  source     = "../iam_role"
  name       = "ecs-task-execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}
