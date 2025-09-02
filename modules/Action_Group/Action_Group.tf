resource "azurerm_monitor_action_group" "Action_Group" {
  count               = length(var.Action_Group)
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Action_Group[count.index].resource_group]]
  location            = var.Action_Group[count.index].location
  name                = "${var.region_mapping[var.Action_Group[count.index].location]}-${var.environment_name}-${var.Action_Group[count.index].name}-${var.service_type}"
  short_name          = var.Action_Group[count.index].short_name

  dynamic "email_receiver" {
    for_each = try(var.Action_Group[count.index].email_receiver != null, null) ? var.Action_Group[count.index].email_receiver : []
    content {
      name          = email_receiver.value.name
      email_address = email_receiver.value.email_address
    }
  }

  dynamic "webhook_receiver" {
    for_each = try(var.Action_Group[count.index].webhook_receiver != null, null) ? var.Action_Group[count.index].webhook_receiver : []
    content {
      name        = webhook_receiver.value.name
      service_uri = webhook_receiver.value.service_uri
    }
  }
}


