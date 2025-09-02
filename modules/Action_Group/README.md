# Action Group Module

Creates Azure Monitor Action Groups for alert notifications and automated responses.

## Purpose
- Alert notification management
- Automated incident response
- Multi-channel notifications
- Integration with monitoring systems

## Resources Created
- `azurerm_monitor_action_group` - Action groups
- Email, SMS, and webhook receivers
- Logic app and function integrations

## Usage
```hcl
module "action_group" {
  source = "../modules/Action_Group"
  
  Action_Group           = var.Action_Group
  resource_group_names   = module.Resource_Group.resource_group_list_name
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["Action_Group"]
  environment_name      = var.environment_mapping[var.env_name]
}
```

## Features
- Multiple notification channels
- Conditional notifications
- Rate limiting
- Integration with Azure services
