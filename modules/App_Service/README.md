# App Service Module

Creates Azure App Service web applications with associated configurations.

## Purpose
- Hosts web applications and APIs
- Provides scalable compute platform
- Integrates with other Azure services

## Resources Created
- `azurerm_linux_web_app` - Web applications
- `azurerm_app_service_slot` - Deployment slots
- Application settings and connection strings
- Custom domains and SSL certificates

## Usage
```hcl
module "app_service" {
  source = "../modules/App_Service"
  
  App_Service            = var.App_Service
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["App_Service"]
  environment_name      = var.environment_mapping[var.env_name]
}
```

## Features
- Auto-scaling capabilities
- Deployment slots for staging
- Custom domains and SSL
- Application insights integration
- VNet integration
- Managed identity support
- Docker container support
