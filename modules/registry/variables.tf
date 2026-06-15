variable "name" {
  description = "Globally-unique ACR name (alphanumeric only)."
  type        = string
}
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "aks_kubelet_object_id" { type = string }
variable "sku" {
  type    = string
  default = "Standard"
}
variable "tags" {
  type    = map(string)
  default = {}
}
