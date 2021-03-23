module "network" {
  source = "./network"

  app_name = var.app_name
}

module "elb" {
  source = "./elb"

  app_name          = var.app_name
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  acm_id            = module.acm.acm_id
}

module "acm" {
  source = "./acm"

  domain = var.domain
}

module "ecs_nginx" {
  source = "./ecs_nginx"

  vpc_id            = module.network.vpc_id
  http_listener_arn = module.elb.http_listener_arn
  cluster_name      = module.ecs_cluster.cluster_name
  public_subnet_ids = module.network.public_subnet_ids
}

module "ecs_cluster" {
  source = "./ecs_cluster"
}
