locals {
  name = "${var.name_prefix}-${var.environment}"
  base_tags = merge(var.tags, {
    environment = var.environment
    managed_by  = "terraform"
    project     = "azure-terraform-demo"
  })
  # ACR & Key Vault names must be globally unique & alphanumeric.
  acr_name = lower(replace("${var.name_prefix}${var.environment}acr", "-", ""))
  kv_name  = lower(replace("${var.name_prefix}-${var.environment}-kv", "_", "-"))
}

resource "azurerm_resource_group" "this" {
  name     = "${local.name}-rg"
  location = var.location
  tags     = local.base_tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "${local.name}-logs"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.base_tags
}

module "network" {
  source              = "./modules/network"
  name_prefix         = local.name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  vnet_cidr           = var.vnet_cidr
  subnet_cidrs        = var.subnet_cidrs
  tags                = local.base_tags
}

module "aks" {
  source                     = "./modules/aks"
  name_prefix                = local.name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.this.name
  subnet_id                  = module.network.subnet_ids["aks"]
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  node_count                 = var.aks_node_count
  vm_size                    = var.aks_vm_size
  tags                       = local.base_tags
}

module "registry" {
  source                = "./modules/registry"
  name                  = local.acr_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.this.name
  aks_kubelet_object_id = module.aks.kubelet_identity_object_id
  sku                   = var.acr_sku
  tags                  = local.base_tags
}

module "keyvault" {
  source              = "./modules/keyvault"
  name                = local.kv_name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  admin_object_id     = data.azurerm_client_config.current.object_id
  tags                = local.base_tags
}
