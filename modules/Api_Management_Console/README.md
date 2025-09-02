# API Management Console Module

Creates Azure API Management service for API gateway and management.

## Purpose
- API gateway and proxy
- API lifecycle management
- Developer portal and documentation
- API security and throttling

## Resources Created
- `azurerm_api_management` - API Management service
- `azurerm_api_management_api` - API definitions
- `azurerm_api_management_policy` - API policies
- `azurerm_api_management_product` - API products

## Usage
```hcl
module "api_management" {
  source = "../modules/Api_Management_Console"
  
  Api_Management_Console = var.Api_Management_Console
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["APIM"]
  environment_name      = var.environment_mapping[var.env_name]
}
```

## Features
- API versioning and revisions
- Rate limiting and quotas
- Authentication and authorization
- Request/response transformation
- Analytics and monitoring
- Developer portal
- Custom domains and SSL
