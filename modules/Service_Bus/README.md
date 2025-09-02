# Service Bus Module

Creates Azure Service Bus for reliable messaging between applications.

## Purpose
- Asynchronous messaging
- Decoupling of applications
- Message queuing and topics
- Enterprise messaging patterns

## Resources Created
- `azurerm_servicebus_namespace` - Service Bus namespace
- `azurerm_servicebus_queue` - Message queues
- `azurerm_servicebus_topic` - Publish/subscribe topics
- `azurerm_servicebus_subscription` - Topic subscriptions

## Usage
```hcl
module "service_bus" {
  source = "../modules/Service_Bus"
  
  Service_Bus            = var.Service_Bus
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["Service_Bus"]
  environment_name      = var.environment_mapping[var.env_name]
}
```

## Features
- FIFO message ordering
- Message sessions
- Dead letter queues
- Duplicate detection
- Message scheduling
- Auto-forwarding
- Geo-disaster recovery
