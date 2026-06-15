variable "environment" {
  description = "Environment name (dev, prod, …). Used in resource names and tags."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "uaenorth"
}

variable "name_prefix" {
  description = "Short prefix for resource names (lowercase, alphanumeric)."
  type        = string
  default     = "tsa"
}

variable "vnet_cidr" {
  description = "Address space for the virtual network."
  type        = string
  default     = "10.20.0.0/16"
}

variable "subnet_cidrs" {
  description = "Map of subnet name => CIDR."
  type        = map(string)
  default = {
    aks      = "10.20.1.0/24"
    services = "10.20.2.0/24"
  }
}

variable "aks_node_count" {
  description = "Number of nodes in the default AKS pool."
  type        = number
  default     = 2
}

variable "aks_vm_size" {
  description = "VM size for AKS nodes."
  type        = string
  default     = "Standard_D2s_v5"
}

variable "acr_sku" {
  description = "Container registry SKU."
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "Extra tags applied to all resources."
  type        = map(string)
  default     = {}
}
