variable "App_Service" {

  type = list(object({
    app_service_plan_id     = string
    client_affinity_enabled = bool
    client_cert_mode        = string
    client_cert_enabled     = bool
    enabled                 = bool
    https_only              = bool
    location                = string
    name                    = string
    resource_group          = string
    tags                    = map(string)
    auth_settings = list(object({
      additional_login_params        = map(string)
      allowed_external_redirect_urls = list(string)
      enabled                        = bool
      token_refresh_extension_hours  = number
      token_store_enabled            = bool
    }))
    connection_string = list(map(string))
    logs = list(object({
      detailed_error_messages_enabled = bool
      failed_request_tracing_enabled  = bool
      application_logs = list(object({
        file_system_level = string
        azure_blob_storage = list(object({
          level             = string
          retention_in_days = number
          sas_url           = string
        }))
      }))
      http_logs = list(object({
        file_system = list(map(string))
      }))
    }))
    identity = list(object({
      identity_ids = list(string)
      type         = string
    }))
    site_config = list(object({
      acr_use_managed_identity_credentials = bool
      always_on                            = bool
      default_documents                    = list(string)
      dotnet_framework_version             = string
      ftps_state                           = string
      http2_enabled                        = bool
      local_mysql_enabled                  = bool
      managed_pipeline_mode                = string
      min_tls_version                      = string
      number_of_workers                    = number
      remote_debugging_enabled             = bool
      scm_type                             = string
      scm_use_main_ip_restriction          = bool
      use_32_bit_worker_process            = bool
      vnet_route_all_enabled               = bool
      websockets_enabled                   = bool
      health_check_path                    = string
      linux_fx_version                     = string
      php_version                          = string
      remote_debugging_version             = string

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
    }))

  }))
  description = "List of App_Service"

}

variable "App_Service_Slot" {
  type = list(object({
    app_service_name        = string
    app_service_plan_id     = string
    client_affinity_enabled = bool
    resource_group          = string
    enabled                 = bool
    https_only              = bool
    location                = string
    name                    = string
    tags                    = map(string)
    auth_settings = list(object({
      additional_login_params        = map(string)
      allowed_external_redirect_urls = list(string)
      enabled                        = bool
      token_refresh_extension_hours  = number
      token_store_enabled            = bool
    }))
    connection_string = list(map(string))
    logs = list(object({
      detailed_error_messages_enabled = bool
      failed_request_tracing_enabled  = bool
      application_logs = list(object({
        file_system_level = string
        azure_blob_storage = list(object({
          level             = string
          retention_in_days = number
          sas_url           = string
        }))
      }))
      http_logs = list(object({
        file_system = list(map(string))
      }))
    }))
    site_config = list(object({
      acr_use_managed_identity_credentials = bool
      always_on                            = bool
      default_documents                    = list(string)
      dotnet_framework_version             = string
      ftps_state                           = string
      http2_enabled                        = bool
      local_mysql_enabled                  = bool
      managed_pipeline_mode                = string
      min_tls_version                      = string
      number_of_workers                    = number
      php_version                          = string
      remote_debugging_enabled             = bool
      scm_ip_restriction                   = list(string)
      scm_type                             = string
      scm_use_main_ip_restriction          = bool
      use_32_bit_worker_process            = bool
      vnet_route_all_enabled               = bool
      websockets_enabled                   = bool

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
    }))
  }))
  description = "List Of App service Slot"

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
  description = "Service type"
}

variable "region_mapping" {
  type        = map(string)
  description = "Region_Mappings"
}

variable "subscription_id" {
  type        = string
  description = "Subscription string for the account"
}

variable "resource_group_mapping" {
  type        = map(string)
  description = "List of resource group mapping to be applied"
}

variable "application_insight_list" {
  type        = map(map(string))
  description = "List of application insight instrumentation_key"
}