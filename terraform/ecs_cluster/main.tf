locals {
  name = "rails-hello"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = local.name
}
