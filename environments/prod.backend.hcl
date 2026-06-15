# Remote state for the prod environment (Azure blob storage).
# Pass with: terraform init -backend-config=environments/prod.backend.hcl
resource_group_name  = "tfstate-rg"
storage_account_name = "tsatfstate"
container_name       = "tfstate"
key                  = "prod.terraform.tfstate"
