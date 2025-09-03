# Variable Input Formats Guide

This document provides the required input formats for all variables to prevent validation errors when using this Terraform configuration.

## Required Variable Formats

### Networking Variables

#### subnets
```hcl
subnets = [
  {
    name                 = "subnet-1"
    resource_group_name  = "rg-network"
    virtual_network_name = "vnet-main"
    address_prefixes     = ["10.0.1.0/24"]
    service_endpoints    = ["Microsoft.Storage", "Microsoft.Sql"]
  }
]
```

#### Nat_Gateway
```hcl
Nat_Gateway = [
  {
    idle_timeout_in_minutes = 4
    location                = "West US"
    name                    = "nat-gateway-1"
    resource_group          = "rg-network"
    sku_name                = "Standard"
    tags                    = { Environment = "test" }
  }
]
```

#### Private_Endpoint
```hcl
Private_Endpoint = [
  {
    location       = "West US"
    name           = "pe-storage"
    resource_group = "rg-network"
    subnet_id      = "/subscriptions/.../subnets/subnet-1"
    tags           = { Environment = "test" }
    
    private_dns_zone_group = [
      {
        name                 = "dns-group"
        private_dns_zone_ids = ["/subscriptions/.../privateDnsZones/privatelink.blob.core.windows.net"]
      }
    ]
    
    private_service_connection = [
      {
        is_manual_connection           = false
        name                           = "psc-storage"
        private_connection_resource_id = "/subscriptions/.../storageAccounts/storage1"
        subresource_names              = ["blob"]
      }
    ]
  }
]
```

#### Private_Dns_Zone
```hcl
Private_Dns_Zone = [
  {
    name           = "privatelink.blob.core.windows.net"
    resource_group = "rg-network"
    tags           = { Environment = "test" }
    
    soa_record = [
      {
        email        = "admin.example.com"
        expire_time  = 2419200
        minimum_ttl  = 300
        refresh_time = 3600
        retry_time   = 300
        ttl          = 3600
      }
    ]
    
    virtual_network_link = [
      {
        name                 = "vnet-link"
        registration_enabled = false
        virtual_network_id   = "/subscriptions/.../virtualNetworks/vnet-main"
      }
    ]
  }
]
```

### Storage Variables

#### Storage_Accounts
```hcl
Storage_Accounts = [
  {
    account_replication_type = "LRS"
    account_tier             = "Standard"
    location                 = "West US"
    name                     = "storage1"
    resource_group           = "rg-storage"
    tags                     = { Environment = "test" }
    
    queue_properties = {
      hour_metrics = [
        {
          enabled               = true
          include_apis          = true
          retention_policy_days = 7
          version               = "1.0"
        }
      ]
    }
    
    network_rules = [
      {
        default_action = "Deny"
        ip_rules       = ["203.0.113.0/24"]
      }
    ]
  }
]
```

### App Service Variables

#### App_Service_Plan_List
```hcl
App_Service_Plan_List = [
  {
    location                     = "West US"
    name                         = "asp-main"
    resource_group               = "rg-app"
    tags                         = { Environment = "test" }
    kind                         = "Linux"
    maximum_elastic_worker_count = 10
    reserved                     = true
    sku = [
      {
        tier = "Standard"
        size = "S1"
      }
    ]
  }
]
```

#### Service_Plan_List
```hcl
Service_Plan_List = [
  {
    location                     = "West US"
    name                         = "sp-main"
    os_type                      = "Linux"
    resource_group               = "rg-app"
    sku_name                     = "P1v2"
    tags                         = { Environment = "test" }
    maximum_elastic_worker_count = 10
    per_site_scaling_enabled     = false
    worker_count                 = 1
    zone_balancing_enabled       = false
  }
]
```

### Database Variables

#### SQL_DB
```hcl
SQL_DB = [
  {
    location       = "West US"
    name           = "database1"
    resource_group = "rg-sql"
    server_name    = "sql-server-1"
    tags           = { Environment = "test" }
    edition        = "Standard"
    max_size_bytes = "268435456000"
  }
]
```

#### Elastic_Job_Agent
```hcl
Elastic_Job_Agent = [
  {
    database_id = {
      "database1" = "/subscriptions/.../databases/database1"
    }
    location = "West US"
    name     = "job-agent-1"
    tags     = { Environment = "test" }
  }
]
```

### Service Bus Variables

#### Service_Bus_Namespace
```hcl
Service_Bus_Namespace = [
  {
    location       = "West US"
    name           = "sb-namespace-1"
    resource_group = "rg-servicebus"
    sku            = "Standard"
    tags           = { Environment = "test" }
    capacity       = 1
  }
]
```

#### Service_Bus_Topic
```hcl
Service_Bus_Topic = [
  {
    enable_batched_operations         = true
    enable_express                    = false
    enable_partitioning               = false
    max_size_in_megabytes            = 1024
    name                             = "topic1"
    namespace_id                     = "/subscriptions/.../namespaces/sb-namespace-1"
    requires_duplicate_detection     = false
    status                           = "Active"
    max_message_size_in_kilobytes    = 256
  }
]
```

#### Queue_List
```hcl
Queue_List = [
  {
    enable_batched_operations     = true
    enable_express                = false
    enable_partitioning           = false
    name                          = "queue1"
    namespace_id                  = "/subscriptions/.../namespaces/sb-namespace-1"
    max_delivery_count            = 10
    max_message_size_in_kilobytes = 256
    max_size_in_megabytes         = 1024
    status                        = "Active"
  }
]
```

#### Subscription_List
```hcl
Subscription_List = [
  {
    max_delivery_count = 10
    name               = "subscription1"
    topic_id           = "/subscriptions/.../topics/topic1"
    requires_session   = false
    status             = "Active"
  }
]
```

### Logic Apps Variables

#### Logic_App_Workflow_List
```hcl
Logic_App_Workflow_List = [
  {
    location            = "West US"
    name                = "logic-app-1"
    resource_group      = "rg-logic"
    tags                = { Environment = "test" }
    enabled             = true
    parameters          = {}
    workflow_parameters = {}
    workflow_schema     = "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#"
    workflow_version    = "1.0.0.0"
  }
]
```

#### Logic_App_Trigger_Recurrence_List
```hcl
Logic_App_Trigger_Recurrence_List = [
  {
    frequency    = "Day"
    interval     = 1
    name         = "trigger1"
    time_zone    = "UTC"
    logic_app_id = "/subscriptions/.../workflows/logic-app-1"
  }
]
```

#### Logic_App_Action_Custom_List
```hcl
Logic_App_Action_Custom_List = [
  {
    body         = "{\"message\": \"Hello World\"}"
    name         = "action1"
    logic_app_id = "/subscriptions/.../workflows/logic-app-1"
  }
]
```

## Empty Lists for Unused Resources

If you don't need certain resources, provide empty lists:

```hcl
# Empty lists for unused resources
subnets = []
Nat_Gateway = []
Private_Endpoint = []
Private_Dns_Zone = []
Service_Bus_Namespace = []
Service_Bus_Topic = []
Queue_List = []
Subscription_List = []
Logic_App_Workflow_List = []
Logic_App_Trigger_Recurrence_List = []
Logic_App_Action_Custom_List = []
Elastic_Job_Agent = []
```

## Notes

1. Replace placeholder values (like subscription IDs, resource IDs) with actual values from your Azure environment
2. Ensure all required attributes are included as shown in the examples
3. Use empty lists `[]` for resources you don't want to create
4. All location values should match your target Azure region
5. Resource group names should match existing or planned resource groups
6. Tags are optional but recommended for resource management
