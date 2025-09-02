# App Service Plan Module

Creates Azure App Service Plans to host web applications and function apps.

## Purpose
- Compute resources for App Services
- Scaling and performance management
- Cost optimization through shared resources

## Resources Created
- `azurerm_service_plan` - App Service Plans
- Scaling configurations
- Performance tier settings

## Usage
```hcl
module "app_service_plan" {
  source = "../modules/App_Service_Plan"
  
  App_Service_Plan       = var.App_Service_Plan
  resource_group_names   = module.Resource_Group.resource_group_list_name
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["App_Service_Plan"]
  environment_name      = var.environment_mapping[var.env_name]
}
```

## Features
- Multiple pricing tiers
- Auto-scaling capabilities
- Linux and Windows support
- Reserved instance options
