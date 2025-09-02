# Application Insights Module

Creates Azure Application Insights for application performance monitoring.

## Purpose
- Application performance monitoring (APM)
- Real-time telemetry collection
- Performance diagnostics
- User behavior analytics

## Resources Created
- `azurerm_application_insights` - Application Insights instance
- `azurerm_application_insights_web_test` - Availability tests
- Custom metrics and alerts
- Dashboard configurations

## Usage
```hcl
module "application_insights" {
  source = "../modules/Application_Insights"
  
  Application_Insights   = var.Application_Insights
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["Application_Insights"]
  environment_name      = var.environment_mapping[var.env_name]
}
```

## Features
- Real-time monitoring
- Custom telemetry
- Dependency tracking
- Exception tracking
- Performance counters
- Live metrics stream
- Smart detection alerts
