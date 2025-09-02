resource "azurerm_resource_group" "resource_group_list" {
  count    = length(var.Resource_Group)
  location = var.Resource_Group[count.index].location
  name     = "${var.region_mapping[var.Resource_Group[count.index].location]}-${var.environment_name}-${var.Resource_Group[count.index].name}-${var.service_type}"
  tags = merge(
    var.Resource_Group[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.Resource_Group[count.index].location
      "service"             = "${var.region_mapping[var.Resource_Group[count.index].location]}-${var.environment_name}-${var.Resource_Group[count.index].name}-${var.service_type}"
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}

output "resource_group_list_name" {
  value = azurerm_resource_group.resource_group_list[*].name
}