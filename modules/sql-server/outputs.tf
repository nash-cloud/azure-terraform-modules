output "id" {
  value = (
    length(azurerm_mssql_server.adl_sql) > 0 ?
    azurerm_mssql_server.adl_sql[0].id : ""
  )
  description = "Resource identifier of the instance of SQL Server."
}

output "name" {
  value = (
    length(azurerm_mssql_server.adl_sql) > 0 ?
    azurerm_mssql_server.adl_sql[0].name : ""
  )
  description = "Name of the SQL Server."
}

output "resource_group_name" {
  value = (
    length(azurerm_mssql_server.adl_sql) > 0 ?
    azurerm_mssql_server.adl_sql[0].resource_group_name : ""
  )
  description = "Resource Group where the SQL Server exists."
}

output "admin_password" {
  value = (
    length(azurerm_mssql_server.adl_sql) > 0 ?
    azurerm_mssql_server.adl_sql[0].administrator_login_password : ""
  )
  description = "Admin password for the SQL Server."
  sensitive   = true
}

output "fully_qualified_domain_name" {
  value = (
    length(azurerm_mssql_server.adl_sql) > 0 ?
    azurerm_mssql_server.adl_sql[0].fully_qualified_domain_name : ""
  )
  description = "The fully qualified domain name of the Azure SQL Server."
}