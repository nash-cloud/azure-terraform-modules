# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_database

resource "azurerm_mssql_database" "adl_sqldb" {
  name               = "sqldb${var.basename}"
  server_id          = var.server_id
  collation          = var.collation
  max_size_gb        = var.max_storage
  sku_name           = var.sku_name
  geo_backup_enabled = var.geo_backup_enabled
  tags               = var.tags

  count = var.module_enabled ? 1 : 0

  #    # Uncomment to prevent the possibility of accidental data loss
  #   lifecycle {
  #     prevent_destroy = true
  #   }
}

## Important:
## Use the following link for the list of Azure SQL Database pricinig
## https://azure.microsoft.com/en-us/pricing/details/azure-sql-database/single/##