locals {
  name = "rails-hello-nginx"
}

resource "aws_ecs_task_definition" "task_definition" {
  family = var.name

  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = data.template_file.container_definitions.rendered
}
