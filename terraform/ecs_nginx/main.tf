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
