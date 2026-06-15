variable "name" {
  description = "Globally-unique Key Vault name."
  type        = string
}
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tenant_id" { type = string }
variable "admin_object_id" {
  description = "Object ID granted Secrets Officer (usually the deploying principal)."
  type        = string
}
variable "tags" {
  type    = map(string)
  default = {}
}
