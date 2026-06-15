output "resource_group" {
  value = azurerm_resource_group.this.name
}

output "aks_cluster_name" {
  value = module.aks.name
}

output "acr_login_server" {
  value = module.registry.login_server
}

output "key_vault_uri" {
  value = module.keyvault.vault_uri
}

output "subnet_ids" {
  value = module.network.subnet_ids
}
