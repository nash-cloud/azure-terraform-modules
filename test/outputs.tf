output "resource_group_name" {
  value = module.data_factory.resource_group_name
}

output "adf_id" {
  value = module.data_factory.id
}

output "adf_name" {
  value = module.data_factory.name
}

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