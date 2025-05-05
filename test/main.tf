module "data_factory" {
  source = "../modules/data-factory/"

  basename            = random_string.postfix.result
  resource_group_name = module.local_rg.name
  location            = module.local_rg.location

  tags = local.tags
}

# Storage account for data factory
module "storage_account" {
  source                              = "../modules/storage-account/"
  basename                            = random_string.postfix.result
  resource_group_name                 = module.local_rg.name
  location                            = var.location
  hns_enabled                         = var.hns_enabled
  firewall_default_action             = var.firewall_default_action
  firewall_ip_rules                   = var.firewall_ip_rules
  firewall_bypass                     = var.firewall_bypass
  firewall_virtual_network_subnet_ids = var.firewall_virtual_network_subnet_ids
  tags                                = local.tags
}

module "user_assigned_identity" {
  source              = "../modules/user-assigned-identity"
  basename            = random_string.postfix.result
  resource_group_name = module.local_rg.name
  location            = var.location
  tags                = {}
}

# Modules dependencies

module "local_rg" {
  source   = "../modules/resource-group/"
  basename = random_string.postfix.result
  location = var.location

  tags = local.tags
}