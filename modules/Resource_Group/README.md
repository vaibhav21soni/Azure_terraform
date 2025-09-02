# Resource Group Module

Creates Azure Resource Groups with standardized naming and tagging.

## Purpose
- Organizes Azure resources into logical containers
- Applies consistent naming conventions
- Implements resource tagging strategy

## Resources Created
- `azurerm_resource_group` - Azure Resource Group

## Usage
```hcl
module "resource_group" {
  source = "../modules/Resource_Group"
  
  Resource_Group   = var.Resource_Group
  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["Resource_Group"]
  environment_name = var.environment_mapping[var.env_name]
}
```

## Inputs
- `Resource_Group` - Resource group configuration
- `region_mapping` - Region code mappings
- `service_type` - Service type identifier
- `environment_name` - Environment identifier

## Outputs
- Resource group names and IDs for use by other modules
