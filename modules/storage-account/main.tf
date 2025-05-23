# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account

data "azurerm_client_config" "current" {}

resource "azurerm_storage_account" "adl_st" {
  name                          = "st${var.basename}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  account_kind                  = var.account_kind
  is_hns_enabled                = var.hns_enabled
  min_tls_version               = var.min_tls_version
  public_network_access_enabled = var.public_network_access_enabled

  # queue_properties {
  #   logging {
  #     delete                = true
  #     read                  = true
  #     write                 = true
  #     version               = "1.0"
  #     retention_policy_days = 10
  #   }
  # }
  tags = var.tags

  count = var.module_enabled ? 1 : 0
}

resource "azurerm_storage_account_queue_properties" "st_queue_properties" {
  storage_account_id = azurerm_storage_account.adl_st[0].id
  # cors_rule {
  #   allowed_origins    = ["http://www.example.com"]
  #   exposed_headers    = ["x-tempo-*"]
  #   allowed_headers    = ["x-tempo-*"]
  #   allowed_methods    = ["GET", "PUT"]
  #   max_age_in_seconds = "500"
  # }

  logging {
    version               = "1.0"
    delete                = true
    read                  = true
    write                 = true
    retention_policy_days = 7
  }

  hour_metrics {
    version               = "1.0"
    retention_policy_days = 7
  }

  minute_metrics {
    version               = "1.0"
    retention_policy_days = 7
  }
}

resource "azurerm_role_assignment" "st_role_admin_c" {
  scope                = azurerm_storage_account.adl_st[0].id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_client_config.current.object_id

  count = var.module_enabled ? 1 : 0
}

resource "azurerm_role_assignment" "st_role_admin_sbdc" {
  scope                = azurerm_storage_account.adl_st[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id

  count = var.module_enabled ? 1 : 0
}

resource "azurerm_storage_data_lake_gen2_filesystem" "st_adls" {
  name               = "default"
  storage_account_id = azurerm_storage_account.adl_st[0].id
  depends_on = [
    azurerm_role_assignment.st_role_admin_sbdc,
    azurerm_storage_account_network_rules.firewall_rules
  ]

  count = var.module_enabled ? 1 : 0
}

resource "azurerm_storage_account_network_rules" "firewall_rules" {
  storage_account_id         = azurerm_storage_account.adl_st[0].id
  default_action             = var.firewall_default_action
  ip_rules                   = var.firewall_ip_rules
  virtual_network_subnet_ids = var.firewall_virtual_network_subnet_ids
  bypass                     = var.firewall_bypass

  count = var.module_enabled ? 1 : 0
}

# Creating madelian container
resource "azurerm_storage_container" "st_container" {
  name                  = var.container_names[count.index]
  storage_account_id    = azurerm_storage_account.adl_st[0].id
  container_access_type = "private"

  count = var.module_enabled ? length(var.container_names) : 0
}
