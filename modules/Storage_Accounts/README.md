# Storage Accounts Module

Creates Azure Storage Accounts for blob, file, and table storage needs.

## Purpose
- Provides scalable cloud storage
- Supports various storage types (blob, file, table, queue)
- Implements security and access controls

## Resources Created
- `azurerm_storage_account` - Storage accounts
- `azurerm_storage_container` - Blob containers
- `azurerm_storage_account_network_rules` - Network access rules

## Usage
```hcl
module "storage_accounts" {
  source = "../modules/Storage_Accounts"
  
  Storage_Accounts       = var.Storage_Accounts
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["Storage_Accounts"]
  environment_name      = var.environment_mapping[var.env_name]
}
```

## Features
- Multiple performance tiers
- Encryption at rest
- Network access restrictions
- Lifecycle management
- Backup and versioning
- Private endpoint support
