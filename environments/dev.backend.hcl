# Remote state for the dev environment (Azure blob storage).
# Pass with: terraform init -backend-config=environments/dev.backend.hcl
resource_group_name  = "tfstate-rg"
storage_account_name = "tsatfstate"
container_name       = "tfstate"
key                  = "dev.terraform.tfstate"
