resource "azurerm_log_analytics_workspace" "Log_Analytics_Workspace" {
  count               = length(var.Log_Analytics_Workspace)
  location            = var.Log_Analytics_Workspace[count.index].location
  name                = "${var.region_mapping[var.Log_Analytics_Workspace[count.index].location]}-${var.environment_name}-${var.Log_Analytics_Workspace[count.index].name}-${var.service_type}"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Log_Analytics_Workspace[count.index].resource_group]]
  tags = merge(
    var.Log_Analytics_Workspace[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.Log_Analytics_Workspace[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}