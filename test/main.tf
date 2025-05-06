data "azurerm_client_config" "current" {}

module "data_factory" {
  source = "../modules/data-factory/"

  basename            = random_string.postfix.result
  resource_group_name = module.local_rg.name
  location            = module.local_rg.location

  tags = local.tags
}

# Storage account for data factory
module "storage_account" {
  source                  = "../modules/storage-account/"
  basename                = random_string.postfix.result
  resource_group_name     = module.local_rg.name
  location                = var.location
  hns_enabled             = var.hns_enabled
  firewall_default_action = var.firewall_default_action
  firewall_ip_rules       = var.firewall_ip_rules
  firewall_bypass         = var.firewall_bypass
  tags = local.tags

}

module "user_assigned_identity" {
  source              = "../modules/user-assigned-identity"
  basename            = random_string.postfix.result
  resource_group_name = module.local_rg.name
  location            = var.location
  tags                = {}
}

module "sql_database_server" {
  source                       = "../modules/sql-server"
  basename                     = random_string.postfix.result
  resource_group_name          = module.local_rg.name
  location                     = var.location
  db_version                   = var.db_version
  administrator_login          = var.sql_server_administrator_login
  administrator_login_password = var.sql_server_administrator_password
  minimum_tls_version          = var.minimum_tls_version
  azuread_administrator = {
    aad_admin = {
      # Ideally should get the UPN using data.azuread_user.current.user_principal_name
      # but the SP used to run the tests lacks permissions to do that
      login_username              = "someusernameforlogin"
      object_id                   = data.azurerm_client_config.current.object_id
      tenant_id                   = data.azurerm_client_config.current.tenant_id
      azuread_authentication_only = false
    }
  }
  tags = local.tags
}

module "sql_database" {
  source    = "../modules/sql-database"
  basename  = random_string.postfix.result
  server_id = module.sql_database_server.id
  tags = local.tags
}

# Modules dependencies

module "local_rg" {
  source   = "../modules/resource-group/"
  basename = random_string.postfix.result
  location = var.location

  tags = local.tags
}
