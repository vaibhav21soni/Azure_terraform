# Log Analytics Workspace Module

Creates Azure Log Analytics Workspace for centralized logging and monitoring.

## Purpose
- Centralized log collection
- Log analysis and querying
- Monitoring and alerting
- Security and compliance logging

## Resources Created
- `azurerm_log_analytics_workspace` - Log Analytics workspace
- `azurerm_log_analytics_solution` - Monitoring solutions
- Data retention policies
- Query and alert configurations

## Usage
```hcl
module "log_analytics" {
  source = "../modules/Log_Analytics_Workspace"
  
  Log_Analytics_Workspace = var.Log_Analytics_Workspace
  resource_group_names     = module.Resource_Group.resource_group_list_name
  resource_group_mapping   = var.resource_group_mapping
  region_mapping           = var.region_mapping
  service_type            = var.service_type_mapping["Log_Analytics_Workspace"]
  environment_name        = var.environment_mapping[var.env_name]
}
```

## Features
- KQL (Kusto Query Language) support
- Custom log ingestion
- Data retention configuration
- Integration with Azure Monitor
- Security and audit logging
- Cost optimization features
