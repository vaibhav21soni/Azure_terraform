# Function App Module

Creates Azure Function Apps for serverless compute workloads.

## Purpose
- Serverless compute platform
- Event-driven processing
- Microservices architecture support

## Resources Created
- `azurerm_linux_function_app` - Function applications
- `azurerm_storage_account` - Function storage
- Application settings and connection strings
- Function-specific configurations

## Usage
```hcl
module "function_app" {
  source = "../modules/Function_app"
  
  Function_App           = var.Function_App
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["Function_App"]
  environment_name      = var.environment_mapping[var.env_name]
}
```

## Features
- Multiple runtime support (.NET, Python, Node.js)
- Consumption and Premium plans
- Timer and HTTP triggers
- Service Bus integration
- Application Insights monitoring
- VNet integration
- Managed identity authentication
