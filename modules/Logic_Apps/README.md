# Logic Apps Module

Creates Azure Logic Apps for workflow automation and integration.

## Purpose
- Workflow automation
- System integration
- Business process automation
- Event-driven processing

## Resources Created
- `azurerm_logic_app_workflow` - Logic App workflows
- `azurerm_logic_app_trigger_*` - Workflow triggers
- `azurerm_logic_app_action_*` - Workflow actions
- Connectors and integrations

## Usage
```hcl
module "logic_apps" {
  source = "../modules/Logic_Apps"
  
  Logic_Apps             = var.Logic_Apps
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["Logic_Apps"]
  environment_name      = var.environment_mapping[var.env_name]
}
```

## Features
- Visual workflow designer
- 200+ built-in connectors
- Schedule-based triggers
- HTTP and webhook triggers
- Conditional logic and loops
- Error handling and retry policies
- Integration with Azure services
