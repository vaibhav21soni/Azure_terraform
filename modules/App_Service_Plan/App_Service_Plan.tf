
resource "azurerm_app_service_plan" "app_service_plan_list" {
  count               = length(var.App_Service_Plan_List)
  location            = var.App_Service_Plan_List[count.index].location
  name                = "${var.region_mapping[var.App_Service_Plan_List[count.index].location]}-${var.environment_name}-${var.App_Service_Plan_List[count.index].name}-${var.service_type}"
  kind                = try(var.App_Service_Plan_List[count.index].kind, "Windows")
  reserved            = var.App_Service_Plan_List[count.index].reserved
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.App_Service_Plan_List[count.index].resource_group]]
  tags = merge(
    var.App_Service_Plan_List[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.App_Service_Plan_List[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
  dynamic "sku" {
    for_each = try(var.App_Service_Plan_List[count.index].sku != null, false) ? var.App_Service_Plan_List[count.index].sku : null
    content {
      capacity = sku.value.capacity
      size     = sku.value.size
      tier     = sku.value.tier
    }
  }
}



resource "azurerm_service_plan" "service_plan_list" {
  count               = length(var.Service_Plan_List)
  location            = var.Service_Plan_List[count.index].location
  name                = "${var.region_mapping[var.Service_Plan_List[count.index].location]}-${var.environment_name}-${var.Service_Plan_List[count.index].name}-${var.service_type}"
  os_type             = var.Service_Plan_List[count.index].os_type
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Service_Plan_List[count.index].resource_group]]
  sku_name            = var.Service_Plan_List[count.index].sku_name
  tags = merge(
    var.Service_Plan_List[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.Service_Plan_List[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}

