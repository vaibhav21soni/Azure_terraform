resource "azurerm_application_insights" "Application_Insights" {
  count               = length(var.Application_Insights)
  application_type    = var.Application_Insights[count.index].application_type
  location            = var.Application_Insights[count.index].location
  name                = "${var.region_mapping[var.Application_Insights[count.index].location]}-${var.environment_name}-${var.Application_Insights[count.index].name}-${var.service_type}"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Application_Insights[count.index].resource_group]]
  workspace_id        = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[var.resource_group_mapping[var.Application_Insights[count.index].resource_group]]}/providers/Microsoft.OperationalInsights/workspaces/${var.Application_Insights[count.index].workspace_id}"
  tags = merge(
    var.Application_Insights[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.Application_Insights[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}

output "application_insight_list" {
  value = {
    for index, name in var.Application_Insights[*].name :
    name => {
      "APPINSIGHTS_INSTRUMENTATIONKEY" : azurerm_application_insights.Application_Insights[index].instrumentation_key
      "APPLICATIONINSIGHTS_CONNECTION_STRING" : azurerm_application_insights.Application_Insights[index].connection_string
    }
  }
  description = "Map for Instrumentation key"
}