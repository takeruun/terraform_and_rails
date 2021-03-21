module "network" {
  source = "./network"

  app_name = var.app_name
}

module "elb" {
  source = "./elb"

  app_name          = var.app_name
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
}

