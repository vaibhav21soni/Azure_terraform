resource "azurerm_logic_app_workflow" "releasedirtyjobactivity" {
  enabled  = true
  location = "westus"
  name     = "w1-tst-releasedirtyjobactivity-la"
  parameters = {
    "$connections" = jsonencode({
      sql = {
        connectionId   = "/subscriptions/9d7b3030-86c9-494e-8e5f-5e55f5b8a9ef/resourceGroups/w1-tst-main-rg/providers/Microsoft.Web/connections/tst-sql-apmc"
        connectionName = "sql"
        id             = "/subscriptions/9d7b3030-86c9-494e-8e5f-5e55f5b8a9ef/providers/Microsoft.Web/locations/westus/managedApis/sql"
  } }) }
  resource_group_name = "w1-tst-main-rg"
  tags = {
    "env"                             = "tst"
    "location"                        = "westus"
    "tr:environment-type"             = "tst"
    "tobeRevisted"                    = "tobeRevisted"
    "tr:application-asset-insight-id" = "208443"
    "tr:financial-identifier"         = "66497"
    "tr:resource-owner"               = "SureprepLLC"
  }
  workflow_parameters = {
    "$connections" = jsonencode({
      defaultValue = {}
      type         = "Object"

  }) }
  workflow_schema  = "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json"
  workflow_version = "1.0.0.0"
}

resource "azurerm_logic_app_workflow" "logic_app_workflow_list" {
  count               = length(var.Logic_App_Workflow_List)
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Logic_App_Workflow_List[count.index].resource_group]]
  location            = var.Logic_App_Workflow_List[count.index].location
  name                = "${var.region_mapping[var.Logic_App_Workflow_List[count.index].location]}-${var.environment_name}-${var.Logic_App_Workflow_List[count.index].name}-${var.service_type}"
  parameters          = var.Logic_App_Workflow_List[count.index].parameters
  workflow_parameters = var.Logic_App_Workflow_List[count.index].workflow_parameters
  workflow_schema     = var.Logic_App_Workflow_List[count.index].workflow_schema
  workflow_version    = var.Logic_App_Workflow_List[count.index].workflow_version
  tags = merge(
    var.Logic_App_Workflow_List[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.Logic_App_Workflow_List[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}

resource "azurerm_logic_app_trigger_recurrence" "recurrence_list" {
  depends_on   = [azurerm_logic_app_workflow.logic_app_workflow_list, azurerm_logic_app_workflow.releasedirtyjobactivity]
  count        = length(var.Logic_App_Trigger_Recurrence_List)
  frequency    = var.Logic_App_Trigger_Recurrence_List[count.index].frequency
  interval     = var.Logic_App_Trigger_Recurrence_List[count.index].interval
  logic_app_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[try(var.resource_group_mapping[var.Logic_App_Trigger_Recurrence_List[count.index].resource_group], 0)]}/providers/Microsoft.Logic/workflows/${var.Logic_App_Trigger_Recurrence_List[count.index].logic_app_id}"
  name         = var.Logic_App_Trigger_Recurrence_List[count.index].name
}

resource "azurerm_logic_app_action_custom" "logic_app_action_custom_list" {
  depends_on   = [azurerm_logic_app_trigger_recurrence.recurrence_list, azurerm_logic_app_workflow.releasedirtyjobactivity]
  count        = length(var.Logic_App_Action_Custom_List)
  body         = var.Logic_App_Action_Custom_List[count.index].body
  logic_app_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[try(var.resource_group_mapping[var.Logic_App_Action_Custom_List[count.index].resource_group], 0)]}/providers/Microsoft.Logic/workflows/${var.Logic_App_Action_Custom_List[count.index].logic_app_id}"
  name         = var.Logic_App_Action_Custom_List[count.index].name
}

