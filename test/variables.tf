variable "env_name" {
  type        = string
  description = "Environment name (dev, test, prod, staging)"

  validation {
    condition     = contains(["dev", "test", "prod", "staging", "qa"], var.env_name)
    error_message = "Environment name must be one of: dev, test, prod, staging, qa."
  }
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.subscription_id))
    error_message = "Subscription ID must be a valid GUID format."
  }
}

variable "environment_mapping" {
  type        = map(string)
  description = "Environment mapping to abbreviated names"

  validation {
    condition     = length(var.environment_mapping) > 0
    error_message = "Environment mapping cannot be empty."
  }
}

variable "region_mapping" {
  type        = map(string)
  description = "Azure region mapping to abbreviated codes"

  validation {
    condition     = length(var.region_mapping) > 0
    error_message = "Region mapping cannot be empty."
  }
}

variable "service_type_mapping" {
  type        = map(string)
  description = "Service type mapping to abbreviated names"

  validation {
    condition     = length(var.service_type_mapping) > 0
    error_message = "Service type mapping cannot be empty."
  }
}

variable "resource_group_mapping" {
  type        = map(string)
  description = "Resource group mapping for organization"

  validation {
    condition     = length(var.resource_group_mapping) > 0
    error_message = "Resource group mapping cannot be empty."
  }
}

variable "Resource_Group" {
  type = list(object({
    location = string
    name     = string
    tags     = map(string)
  }))
  description = "List of resource groups to create"

  validation {
    condition     = length(var.Resource_Group) > 0
    error_message = "At least one resource group must be defined."
  }
}

variable "Action_Group" {
  type = list(object({
    enabled          = bool
    location         = string
    name             = string
    resource_group   = string
    short_name       = string
    email_receiver   = list(map(string))
    webhook_receiver = list(map(string))
  }))
  description = "List of Azure Monitor action groups"
  default     = []
}

variable "api_management_console_list" {
  type = list(object({
    client_certificate_enabled    = bool
    gateway_disabled              = bool
    location                      = string
    name                          = string
    notification_sender_email     = string
    public_network_access_enabled = bool
    publisher_email               = string
    publisher_name                = string
    resource_group                = string
    sku_name                      = string
    tags                          = map(string)
    delegation                    = list(map(string))
    hostname_configuration = list(object({
      proxy = map(string)
    }))
  }))
  description = "List of API Management Console configurations"
  default     = []
}

variable "api_connection_details" {
  type = list(object({
    name           = string
    resource_group = string
    tags           = map(string)
  }))
  description = "SQL API connection configurations"
  default     = []
}

variable "App_Service" {
  type = list(object({
    app_service_plan_id = string
    location            = string
    name                = string
    resource_group      = string
    tags                = map(string)

    app_settings = list(object({
      name  = string
      value = string
    }))

    connection_string = list(object({
      name  = string
      type  = string
      value = string
    }))

    site_config = list(object({
      always_on                 = bool
      app_command_line          = string
      auto_heal_enabled         = bool
      default_documents         = list(string)
      dotnet_framework_version  = string
      ftps_state                = string
      health_check_path         = string
      http2_enabled             = bool
      ip_restriction            = list(map(string))
      linux_fx_version          = string
      local_mysql_enabled       = bool
      managed_pipeline_mode     = string
      min_tls_version           = string
      remote_debugging_enabled  = bool
      remote_debugging_version  = string
      scm_type                  = string
      use_32_bit_worker_process = bool
      websockets_enabled        = bool
      windows_fx_version        = string
    }))
  }))
  description = "List of App Service configurations"
  default     = []
}

variable "App_Service_Slot" {
  type = list(object({
    app_service_name = string
    location         = string
    name             = string
    resource_group   = string
    tags             = map(string)

    app_settings = list(object({
      name  = string
      value = string
    }))

    connection_string = list(object({
      name  = string
      type  = string
      value = string
    }))

    site_config = list(object({
      always_on                 = bool
      app_command_line          = string
      auto_heal_enabled         = bool
      default_documents         = list(string)
      dotnet_framework_version  = string
      ftps_state                = string
      health_check_path         = string
      http2_enabled             = bool
      ip_restriction            = list(map(string))
      linux_fx_version          = string
      local_mysql_enabled       = bool
      managed_pipeline_mode     = string
      min_tls_version           = string
      remote_debugging_enabled  = bool
      remote_debugging_version  = string
      scm_type                  = string
      use_32_bit_worker_process = bool
      websockets_enabled        = bool
      windows_fx_version        = string
    }))
  }))
  description = "List of App Service deployment slots"
  default     = []
}

variable "App_Service_Plan_List" {
  type = list(object({
    location       = string
    name           = string
    resource_group = string
    tags           = map(string)
    sku            = list(map(string))
  }))
  description = "List of App Service Plans"
  default     = []
}

variable "Service_Plan_List" {
  type = list(object({
    location       = string
    name           = string
    os_type        = string
    resource_group = string
    sku_name       = string
    tags           = map(string)
  }))
  description = "List of Service Plans"
  default     = []
}

variable "Application_Insights" {
  type = list(object({
    application_type = string
    location         = string
    name             = string
    resource_group   = string
    tags             = map(string)
    workspace_id     = string
  }))
  description = "List of Application Insights instances"
  default     = []
}

variable "Function_App_List" {
  type = list(object({
    app_service_plan_id        = string
    location                   = string
    name                       = string
    resource_group             = string
    storage_account_access_key = string
    storage_account_name       = string
    tags                       = map(string)

    app_settings = list(object({
      name  = string
      value = string
    }))

    connection_string = list(object({
      name  = string
      type  = string
      value = string
    }))

    site_config = list(object({
      always_on                 = bool
      app_command_line          = string
      auto_heal_enabled         = bool
      default_documents         = list(string)
      dotnet_framework_version  = string
      ftps_state                = string
      health_check_path         = string
      http2_enabled             = bool
      ip_restriction            = list(map(string))
      linux_fx_version          = string
      local_mysql_enabled       = bool
      managed_pipeline_mode     = string
      min_tls_version           = string
      remote_debugging_enabled  = bool
      remote_debugging_version  = string
      scm_type                  = string
      use_32_bit_worker_process = bool
      websockets_enabled        = bool
      windows_fx_version        = string
    }))
  }))
  description = "List of Function Apps and their configurations"
  default     = []
}

variable "Key_Vault" {
  type = list(object({
    location       = string
    name           = string
    resource_group = string
    sku_name       = string
    tags           = map(string)

    access_policy = list(object({
      application_id          = string
      certificate_permissions = list(string)
      key_permissions         = list(string)
      object_id               = string
      secret_permissions      = list(string)
      storage_permissions     = list(string)
      tenant_id               = string
    }))
  }))
  description = "List of Key Vault configurations"
  default     = []
}

variable "Log_Analytics_Workspace" {
  type = list(object({
    location          = string
    name              = string
    resource_group    = string
    retention_in_days = number
    sku               = string
    tags              = map(string)
  }))
  description = "List of Log Analytics Workspaces"
  default     = []
}

variable "Logic_App_Workflow_List" {
  type = list(object({
    location       = string
    name           = string
    resource_group = string
    tags           = map(string)
  }))
  description = "List of Logic App Workflows"
  default     = []
}

variable "Logic_App_Trigger_Recurrence_List" {
  type = list(object({
    frequency = string
    interval  = number
    name      = string
    time_zone = string
  }))
  description = "List of Logic App Recurrence Triggers"
  default     = []
}

variable "Logic_App_Action_Custom_List" {
  type = list(object({
    body = string
    name = string
  }))
  description = "List of Logic App Custom Actions"
  default     = []
}

variable "Managed_Identities" {
  type = list(object({
    location       = string
    name           = string
    resource_group = string
    tags           = map(string)
  }))
  description = "List of Managed Identity configurations"
  default     = []
}

variable "VNET" {
  type = list(object({
    address_space  = list(string)
    location       = string
    name           = string
    resource_group = string
    tags           = map(string)
  }))
  description = "List of Virtual Networks"
  default     = []
}

variable "subnets" {
  type = list(object({
    address_prefixes     = list(string)
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
  }))
  description = "List of Subnets"
  default     = []
}

variable "Nat_Gateway" {
  type = list(object({
    location       = string
    name           = string
    resource_group = string
    sku_name       = string
    tags           = map(string)
  }))
  description = "List of NAT Gateways"
  default     = []
}

variable "NSG" {
  type = list(object({
    location       = string
    name           = string
    resource_group = string
    tags           = map(string)

    security_rule = list(object({
      access                                     = string
      description                                = string
      destination_address_prefix                 = string
      destination_address_prefixes               = list(string)
      destination_application_security_group_ids = list(string)
      destination_port_range                     = string
      destination_port_ranges                    = list(string)
      direction                                  = string
      name                                       = string
      priority                                   = number
      protocol                                   = string
      source_address_prefix                      = string
      source_address_prefixes                    = list(string)
      source_application_security_group_ids      = list(string)
      source_port_range                          = string
      source_port_ranges                         = list(string)
    }))
  }))
  description = "List of Network Security Groups"
  default     = []
}

variable "Private_Dns_Zone" {
  type = list(object({
    name           = string
    resource_group = string
    tags           = map(string)

    virtual_network_link = list(object({
      name                 = string
      registration_enabled = bool
      virtual_network_id   = string
    }))
  }))
  description = "List of Private DNS Zones"
  default     = []
}

variable "Private_Endpoint" {
  type = list(object({
    location       = string
    name           = string
    resource_group = string
    subnet_id      = string
    tags           = map(string)

    private_service_connection = list(object({
      is_manual_connection           = bool
      name                           = string
      private_connection_resource_id = string
      subresource_names              = list(string)
    }))
  }))
  description = "List of Private Endpoints"
  default     = []
}

variable "Public_Ip_Prefix" {
  type = list(object({
    location       = string
    name           = string
    prefix_length  = number
    resource_group = string
    sku            = string
    tags           = map(string)
  }))
  description = "List of Public IP Prefixes"
  default     = []
}

variable "Service_Bus_Namespace" {
  type = list(object({
    location       = string
    name           = string
    resource_group = string
    sku            = string
    tags           = map(string)
  }))
  description = "List of Service Bus Namespaces"
  default     = []
}

variable "Service_Bus_Topic" {
  type = list(object({
    enable_batched_operations    = bool
    enable_express               = bool
    enable_partitioning          = bool
    max_size_in_megabytes        = number
    name                         = string
    namespace_id                 = string
    requires_duplicate_detection = bool
    status                       = string
  }))
  description = "List of Service Bus Topics"
  default     = []
}

variable "Queue_List" {
  type = list(object({
    enable_batched_operations = bool
    enable_express            = bool
    enable_partitioning       = bool
    name                      = string
    namespace_id              = string
  }))
  description = "List of Service Bus Queues"
  default     = []
}

variable "Subscription_List" {
  type = list(object({
    max_delivery_count = number
    name               = string
    topic_id           = string
  }))
  description = "List of Service Bus Subscriptions"
  default     = []
}

variable "SQL_Server_Replica" {
  type = list(object({
    administrator_login          = string
    administrator_login_password = string
    location                     = string
    name                         = string
    resource_group               = string
    tags                         = map(string)
    version                      = string
  }))
  description = "List of SQL Server Replicas"
  default     = []
}

variable "Replica_SQL_DB" {
  type = list(object({
    create_mode    = string
    location       = string
    name           = string
    resource_group = string
    server_name    = string
    tags           = map(string)
  }))
  description = "List of Replica SQL Databases"
  default     = []
}

variable "SQL_Server" {
  type = list(object({
    administrator_login          = string
    administrator_login_password = string
    location                     = string
    name                         = string
    resource_group               = string
    tags                         = map(string)
    version                      = string
  }))
  description = "List of SQL Servers"
  default     = []
}

variable "SQL_DB" {
  type = list(object({
    location       = string
    name           = string
    resource_group = string
    server_name    = string
    tags           = map(string)
  }))
  description = "List of SQL Databases"
  default     = []
}

variable "Redis_Cache" {
  type = list(object({
    capacity                      = number
    enable_non_ssl_port           = bool
    family                        = string
    location                      = string
    minimum_tls_version           = string
    name                          = string
    public_network_access_enabled = bool
    resource_group                = string
    sku_name                      = string
    tags                          = map(string)
    redis_configuration           = list(map(string))
  }))
  description = "List of Redis Cache instances"
  default     = []
}

variable "Elastic_Job_Agent" {
  type = list(object({
    database_id = string
    location    = string
    name        = string
    tags        = map(string)
  }))
  description = "List of Elastic Job Agents"
  default     = []
}

variable "Storage_Accounts" {
  type = list(object({
    account_replication_type = string
    account_tier             = string
    location                 = string
    name                     = string
    resource_group           = string
    tags                     = map(string)

    network_rules = list(object({
      default_action = string
      ip_rules       = list(string)
    }))
  }))
  description = "List of Storage Accounts"
  default     = []
}
