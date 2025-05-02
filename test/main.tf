module "data_factory" {
  source = "../modules/data-factory/"

  basename            = random_string.postfix.result
  resource_group_name = module.local_rg.name
  location            = module.local_rg.location

  tags = local.tags
}

# Module dependencies

module "local_rg" {
  source = "../modules/resource-group/"

  basename = random_string.postfix.result
  location = var.location

  tags = local.tags
}
