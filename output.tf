output "resource_group_name" {
  description = "Nombre del resource group creado"
  value       = module.resource_group.resource_group_name
}

output "storage_account_name" {
  description = "Nombre del storage account creado"
  value       = module.storage_account.storage_account_name
}

output "storage_container_name" {
  description = "Nombre del container creado"
  value       = module.storage_account.storage_container_name
}
