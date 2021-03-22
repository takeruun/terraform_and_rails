locals {
  name = "rails-hello-nginx"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = local.name
}
