variable "Function_App_List" {
  type = list(object({
    app_service_plan_id        = string
    https_only                 = bool
    location                   = string
    name                       = string
    resource_group             = string
    storage_account_access_key = string
    storage_account_name       = string
    tags                       = map(string)
    version                    = string
    connection_string          = list(map(string))

    identity = list(object({
      identity_ids = list(string)
      type         = string
    }))

    site_config = list(object({
      always_on                        = bool
      app_scale_limit                  = number
      dotnet_framework_version         = string
      elastic_instance_minimum         = number
      ftps_state                       = string
      http2_enabled                    = bool
      min_tls_version                  = string
      pre_warmed_instance_count        = number
      runtime_scale_monitoring_enabled = bool
      scm_ip_restriction = list(object({
        ip_address                = string
        service_tag               = string
        virtual_network_subnet_id = string
        name                      = string
        priority                  = number
        action                    = string
        headers = list(object({
          x_azure_fdid      = list(string)
          x_fd_health_probe = list(string)
          x_forwarded_for   = list(string)
          x_forwarded_host  = list(string)
        }))
      }))
      scm_type                    = string
      scm_use_main_ip_restriction = bool
      use_32_bit_worker_process   = bool
      vnet_route_all_enabled      = bool
      websockets_enabled          = bool

      ip_restriction = list(object({
        action = string
        headers = list(object({
          x_azure_fdid      = list(string)
          x_fd_health_probe = list(string)
          x_forwarded_for   = list(string)
          x_forwarded_host  = list(string)
        }))
        ip_address = string
        name       = string
        priority   = number
      }))

      cors = list(object({
        allowed_origins     = list(string)
        support_credentials = bool
      }))

    }))
  }))

  description = "List of Function Apps and parameters"


}

variable "resource_group_names" {
  type        = list(string)
  description = "Resource Group Name list"
  default     = []
}

variable "environment_name" {
  type        = string
  description = "Environment name"
}

variable "service_type" {
  type        = string
  description = "Service Type"
}

variable "region_mapping" {
  type        = map(string)
  description = "Region_Mappings"
}

variable "subscription_id" {
  type        = string
  description = "Subscription string for the account"
}

variable "storage_accounts" {
  type = map(string)
}
variable "resource_group_mapping" {
  type        = map(string)
  description = "List of resource group mapping to be applied"
}

variable "application_insight_list" {
  type        = map(map(string))
  description = "List of application insight instrumentation_key"
}