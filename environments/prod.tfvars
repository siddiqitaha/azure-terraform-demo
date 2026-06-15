environment = "prod"
location    = "uaenorth"
name_prefix = "tsa"
vnet_cidr   = "10.30.0.0/16"
subnet_cidrs = {
  aks      = "10.30.1.0/24"
  services = "10.30.2.0/24"
}
aks_node_count = 4
aks_vm_size    = "Standard_D4s_v5"
acr_sku        = "Premium"

tags = {
  cost_center = "engineering"
  owner       = "taha"
  tier        = "production"
}
