# Resource Group Outputs
output "resource_group_name" {
  value = module.data_factory.resource_group_name
}

# Azure Datafactory Outputs
output "adf_id" {
  value = module.data_factory.id
}

output "adf_name" {
  value = module.data_factory.name
}

# Azure Storage Account Outputs
output "storage_id" {
  value = module.storage_account.id
}

output "storage_name" {
  value = module.storage_account.name
}

output "storage_adls_id" {
  value = module.storage_account.adls_id
}

output "storage_access_key" {
  value     = module.storage_account.access_key
  sensitive = true
}

# User Assigned Identity Outputs
output "id" {
  value = module.user_assigned_identity.id
}

output "name" {
  value = module.user_assigned_identity.name
}

output "principal_id" {
  value = module.user_assigned_identity.principal_id
}