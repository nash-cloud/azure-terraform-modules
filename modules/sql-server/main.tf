# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_server

resource "azurerm_mssql_server" "adl_sql" {
  name                         = "sql-${var.basename}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.db_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  minimum_tls_version          = var.minimum_tls_version
  # sku_name  = var.sku_name
  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator
    content {
      login_username              = azuread_administrator.value["login_username"]
      object_id                   = azuread_administrator.value["object_id"]
      tenant_id                   = azuread_administrator.value["tenant_id"]
      azuread_authentication_only = azuread_administrator.value["azuread_authentication_only"]
    }
  }
  tags = var.tags

  count = var.module_enabled ? 1 : 0
}

resource "azurerm_mssql_firewall_rule" "azureservice_rule" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.adl_sql[0].id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"

  count = var.module_enabled ? 1 : 0
}

resource "azurerm_mssql_firewall_rule" "localip_rule" {
  name             = "AllowMyIp"
  server_id        = azurerm_mssql_server.adl_sql[0].id
  start_ip_address = "172.4.240.82"
  end_ip_address   = "172.4.240.82"

  count = var.module_enabled ? 1 : 0
}
