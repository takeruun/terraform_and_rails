data "template_file" "container_definitions" {
  template = file("./ecs_nginx/container_definitions.json")
}
