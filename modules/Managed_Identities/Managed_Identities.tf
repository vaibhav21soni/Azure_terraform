resource "azurerm_user_assigned_identity" "Managed_Identities" {
  count               = length(var.Managed_Identities)
  location            = var.Managed_Identities[count.index].location
  name                = "${var.region_mapping[var.Managed_Identities[count.index].location]}-${var.environment_name}-${var.Managed_Identities[count.index].name}-${var.service_type}"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Managed_Identities[count.index].resource_group]]
  tags = merge(
    var.Managed_Identities[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.Managed_Identities[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}