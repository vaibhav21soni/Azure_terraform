# Key Vault Module

Creates Azure Key Vault for secure storage of secrets, keys, and certificates.

## Purpose
- Centralized secrets management
- Secure storage for connection strings and passwords
- Integration with Azure services via managed identities

## Resources Created
- `azurerm_key_vault` - Azure Key Vault
- `azurerm_key_vault_access_policy` - Access policies
- `azurerm_key_vault_secret` - Stored secrets

## Usage
```hcl
module "key_vault" {
  source = "../modules/Key_Vault"
  
  Key_Vault              = var.Key_Vault
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["Key_Vault"]
  environment_name      = var.environment_mapping[var.env_name]
  subscription_id       = var.subscription_id
}
```

## Features
- Soft delete protection
- Purge protection
- RBAC integration
- Network access restrictions
- Audit logging
