resource "azurerm_servicebus_namespace" "Service_Bus" {
  count               = length(var.Service_Bus_Namespace)
  location            = var.Service_Bus_Namespace[count.index].location
  name                = "${var.region_mapping[var.Service_Bus_Namespace[count.index].location]}-${var.environment_name}-${var.Service_Bus_Namespace[count.index].name}-${var.service_type}-ns"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Service_Bus_Namespace[count.index].resource_group]]
  capacity            = var.Service_Bus_Namespace[count.index].capacity
  sku                 = var.Service_Bus_Namespace[count.index].sku
  tags = merge(
    var.Service_Bus_Namespace[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.Service_Bus_Namespace[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}

resource "azurerm_servicebus_topic" "topic_list" {
  depends_on                    = [azurerm_servicebus_namespace.Service_Bus]
  count                         = length(var.Service_Bus_Topic)
  name                          = "${var.environment_name}-${var.Service_Bus_Topic[count.index].name}-${var.service_type}-top"
  namespace_id                  = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[try(var.resource_group_mapping[var.Service_Bus_Topic[count.index].resource_group], 0)]}/providers/Microsoft.ServiceBus/namespaces/${var.Service_Bus_Topic[count.index].namespace_id}"
  max_message_size_in_kilobytes = var.Service_Bus_Topic[count.index].max_message_size_in_kilobytes
  max_size_in_megabytes         = var.Service_Bus_Topic[count.index].max_size_in_megabytes
  status                        = var.Service_Bus_Topic[count.index].status
}

resource "azurerm_servicebus_subscription" "subscription_list" {
  depends_on         = [azurerm_servicebus_topic.topic_list]
  count              = length(var.Subscription_List)
  max_delivery_count = var.Subscription_List[count.index].max_delivery_count
  name               = "${var.environment_name}-${var.Subscription_List[count.index].name}-${var.service_type}-sub"
  topic_id           = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[try(var.resource_group_mapping[var.Subscription_List[count.index].resource_group], 0)]}/providers/Microsoft.ServiceBus/namespaces/${var.Subscription_List[count.index].topic_id.namespace_id}/topics/${var.Subscription_List[count.index].topic_id.name}"
}

resource "azurerm_servicebus_queue" "queue_list" {
  depends_on                    = [azurerm_servicebus_namespace.Service_Bus]
  count                         = length(var.Queue_List)
  name                          = "${var.environment_name}-${var.Queue_List[count.index].name}-${var.service_type}-que"
  namespace_id                  = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[try(var.resource_group_mapping[var.Queue_List[count.index].resource_group], 0)]}/providers/Microsoft.ServiceBus/namespaces/${var.Queue_List[count.index].namespace_id}"
  status                        = var.Queue_List[count.index].status
  max_message_size_in_kilobytes = var.Queue_List[count.index].max_message_size_in_kilobytes
  max_size_in_megabytes         = var.Queue_List[count.index].max_size_in_megabytes
}
