# Backend is configured per-environment via -backend-config (see environments/*.backend.hcl).
# Left empty here so `terraform init -backend=false` works for validation in CI.
terraform {
  backend "azurerm" {}
}
