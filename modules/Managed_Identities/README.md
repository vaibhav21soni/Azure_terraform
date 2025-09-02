# Managed Identities Module

Creates Azure Managed Identities for secure authentication without credentials.

## Purpose
- Passwordless authentication
- Secure service-to-service communication
- Simplified credential management
- Integration with Azure RBAC

## Resources Created
- `azurerm_user_assigned_identity` - User-assigned identities
- Role assignments and permissions
- Service principal configurations

## Usage
```hcl
module "managed_identities" {
  source = "../modules/Managed_Identities"
  
  Managed_Identities     = var.Managed_Identities
  resource_group_names   = module.Resource_Group.resource_group_list_name
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["Managed_Identities"]
  environment_name      = var.environment_mapping[var.env_name]
}
```

## Features
- System and user-assigned identities
- Automatic credential rotation
- RBAC integration
- Cross-service authentication
