# Azure Terraform Demo — AKS Platform

Production-shaped **infrastructure-as-code** for a containerized platform on Azure: a virtual network,
an **AKS** cluster wired to **Log Analytics**, a **Container Registry** the cluster can pull from
without credentials, and a **Key Vault** — all from reusable modules with clean **dev/prod**
separation and a CI pipeline.

> A clean, client-free reference of the kind of Azure IaC I build (migrations to AKS, IaC-driven
> environments, RBAC & secret management).

## What it provisions

```
Resource Group
├─ Virtual Network (+ subnets: aks, services) + NSG
├─ Log Analytics Workspace
├─ AKS cluster            (system-assigned identity, azure CNI, OMS agent → Log Analytics)
├─ Container Registry     (AcrPull role granted to the AKS kubelet identity)
└─ Key Vault              (RBAC-authorized; deployer gets Secrets Officer)
```

## Layout

```
main.tf / variables.tf / outputs.tf   # root composition
providers.tf / versions.tf / backend.tf
modules/
  network/    # VNet, subnets, NSG
  aks/        # AKS + monitoring
  registry/   # ACR + AcrPull role assignment
  keyvault/   # Key Vault (RBAC)
environments/
  dev.tfvars   prod.tfvars            # per-env inputs (sizes, CIDRs, SKUs)
  dev.backend.hcl  prod.backend.hcl   # per-env remote state
.github/workflows/terraform.yml       # fmt + validate, then plan per env
```

## Usage

```bash
# validate (no cloud creds needed)
terraform init -backend=false
terraform validate

# plan against an environment (needs Azure credentials + a state storage account)
terraform init -backend-config=environments/dev.backend.hcl
terraform plan  -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
```

Authenticate via the Azure CLI (`az login`) or service-principal env vars
(`ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`).

## Design choices

- **Reusable modules** — each resource group of concerns is its own module with typed inputs/outputs.
- **Environment isolation** — same code, different `*.tfvars` + separate remote state keys; prod uses
  bigger nodes, a Premium registry, and its own address space.
- **Least privilege** — ACR access is a scoped `AcrPull` role assignment to the cluster identity;
  Key Vault uses RBAC, not access policies.
- **Observability built in** — AKS ships logs/metrics to Log Analytics out of the box.
- **CI** — every PR runs `fmt`, `validate`, and a `plan` for both environments.

## License

MIT
