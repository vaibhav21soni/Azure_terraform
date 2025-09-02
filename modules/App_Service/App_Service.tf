resource "azurerm_app_service" "app_service_list" {
  count               = length(var.App_Service)
  app_service_plan_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[var.resource_group_mapping[var.App_Service[count.index].resource_group]]}/providers/Microsoft.Web/serverfarms/${var.App_Service[count.index].app_service_plan_id}"
  location            = var.App_Service[count.index].location
  name                = "${var.region_mapping[var.App_Service[count.index].location]}-${var.environment_name}-${var.App_Service[count.index].name}-${var.service_type}"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.App_Service[count.index].resource_group]]
  tags = merge(
    var.App_Service[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.App_Service[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"             = try(lookup(var.application_insight_list, var.App_Service[count.index].name, null) != null) ? lookup(var.application_insight_list, var.App_Service[count.index].name, null).APPINSIGHTS_INSTRUMENTATIONKEY : null
    "APPLICATIONINSIGHTS_CONNECTION_STRING"      = try(lookup(var.application_insight_list, var.App_Service[count.index].name, null) != null) ? lookup(var.application_insight_list, var.App_Service[count.index].name, null).APPLICATIONINSIGHTS_CONNECTION_STRING : null
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
  }
  dynamic "identity" {
    for_each = var.App_Service[count.index].identity != null ? var.App_Service[count.index].identity : []
    content {
      identity_ids = formatlist("/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[var.resource_group_mapping[var.App_Service[count.index].resource_group]]}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/%s", identity.value.identity_ids)
      type         = identity.value.type
    }
  }


  dynamic "auth_settings" {
    for_each = var.App_Service[count.index].auth_settings != null ? var.App_Service[count.index].auth_settings : []
    content {
      additional_login_params        = auth_settings.value.additional_login_params
      allowed_external_redirect_urls = auth_settings.value.allowed_external_redirect_urls
      enabled                        = auth_settings.value.enabled
      token_refresh_extension_hours  = auth_settings.value.token_refresh_extension_hours
      token_store_enabled            = auth_settings.value.token_store_enabled
    }
  }

  dynamic "logs" {
    for_each = var.App_Service[count.index].logs != null ? var.App_Service[count.index].logs : []
    content {
      detailed_error_messages_enabled = logs.value.detailed_error_messages_enabled
      failed_request_tracing_enabled  = logs.value.failed_request_tracing_enabled

      dynamic "application_logs" {
        for_each = logs.value.application_logs != null ? logs.value.application_logs : []
        content {
          file_system_level = application_logs.value.file_system_level
          dynamic "azure_blob_storage" {
            for_each = application_logs.value.azure_blob_storage != null ? application_logs.value.azure_blob_storage : []
            content {
              level             = azure_blob_storage.value.level
              retention_in_days = azure_blob_storage.value.retention_in_days
              sas_url           = azure_blob_storage.value.sas_url
            }
          }
        }

      }

      dynamic "http_logs" {
        for_each = logs.value.http_logs != null ? logs.value.http_logs : []
        content {
          dynamic "file_system" {
            for_each = http_logs.value.file_system != null ? http_logs.value.file_system : []
            content {
              retention_in_days = file_system.value.retention_in_days
              retention_in_mb   = file_system.value.retention_in_mb
            }

          }
        }

      }
    }

  }

  dynamic "site_config" {
    for_each = var.App_Service[count.index].site_config != null ? var.App_Service[count.index].site_config : []
    content {
      acr_use_managed_identity_credentials = try(site_config.value.acr_use_managed_identity_credentials, null)
      acr_user_managed_identity_client_id  = try(site_config.value.acr_user_managed_identity_client_id, null)
      always_on                            = try(site_config.value.always_on, null)
      app_command_line                     = try(site_config.value.app_command_line, null)
      auto_swap_slot_name                  = try(site_config.value.auto_swap_slot_name, null)
      default_documents                    = try(site_config.value.default_documents, null)
      dotnet_framework_version             = try(site_config.value.dotnet_framework_version, null)
      ftps_state                           = try(site_config.value.ftps_state, null)
      health_check_path                    = try(site_config.value.health_check_path, null)
      number_of_workers                    = try(site_config.value.number_of_workers, null)
      http2_enabled                        = try(site_config.value.http2_enabled, null)
      scm_use_main_ip_restriction          = try(site_config.value.scm_use_main_ip_restriction, null)
      java_version                         = try(site_config.value.java_version, null)
      java_container                       = try(site_config.value.java_container, null)
      java_container_version               = try(site_config.value.java_container_version, null)
      local_mysql_enabled                  = try(site_config.value.local_mysql_enabled, null)
      linux_fx_version                     = try(site_config.value.linux_fx_version, null)
      windows_fx_version                   = try(site_config.value.windows_fx_version, null)
      managed_pipeline_mode                = try(site_config.value.managed_pipeline_mode, null)
      min_tls_version                      = try(site_config.value.min_tls_version, null)
      php_version                          = try(site_config.value.php_version, null)
      python_version                       = try(site_config.value.python_version, null)
      remote_debugging_enabled             = try(site_config.value.remote_debugging_enabled, null)
      remote_debugging_version             = try(site_config.value.remote_debugging_version, null)
      scm_type                             = try(site_config.value.scm_type, null)
      use_32_bit_worker_process            = try(site_config.value.use_32_bit_worker_process, null)
      vnet_route_all_enabled               = try(site_config.value.vnet_route_all_enabled, null)
      websockets_enabled                   = try(site_config.value.websockets_enabled, null)

      dynamic "ip_restriction" {
        for_each = site_config.value.ip_restriction != null ? site_config.value.ip_restriction : []
        content {
          action     = ip_restriction.value.action
          headers    = ip_restriction.value.headers
          ip_address = ip_restriction.value.ip_address
          name       = ip_restriction.value.name
          priority   = ip_restriction.value.priority
        }
      }

      dynamic "scm_ip_restriction" {
        for_each = site_config.value.scm_ip_restriction != null ? site_config.value.scm_ip_restriction : []
        content {
          ip_address                = scm_ip_restriction.value.ip_address
          service_tag               = scm_ip_restriction.value.service_tag
          virtual_network_subnet_id = scm_ip_restriction.value.virtual_network_subnet_id
          name                      = scm_ip_restriction.value.name
          priority                  = scm_ip_restriction.value.priority
          action                    = scm_ip_restriction.value.action
          headers                   = scm_ip_restriction.value.headers
        }
      }
    }
  }
}

resource "azurerm_app_service_slot" "PreProdSlot" {
  depends_on = [
    azurerm_app_service.app_service_list
  ]
  count                   = length(var.App_Service_Slot)
  app_service_name        = var.App_Service_Slot[count.index].app_service_name
  app_service_plan_id     = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[var.resource_group_mapping[var.App_Service_Slot[count.index].resource_group]]}/providers/Microsoft.Web/serverfarms/${var.App_Service_Slot[count.index].app_service_plan_id}"
  client_affinity_enabled = var.App_Service_Slot[count.index].client_affinity_enabled
  enabled                 = var.App_Service_Slot[count.index].enabled
  https_only              = var.App_Service_Slot[count.index].https_only
  location                = var.App_Service_Slot[count.index].location
  name                    = "${var.region_mapping[var.App_Service_Slot[count.index].location]}-${var.environment_name}-${var.App_Service_Slot[count.index].name}-${var.service_type}"
  resource_group_name     = var.resource_group_names[var.resource_group_mapping[var.App_Service_Slot[count.index].resource_group]]
  tags = merge(
    var.App_Service_Slot[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.App_Service_Slot[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )

  dynamic "auth_settings" {
    for_each = var.App_Service_Slot[count.index].auth_settings != null ? var.App_Service_Slot[count.index].auth_settings : []
    content {
      additional_login_params        = auth_settings.value.additional_login_params
      allowed_external_redirect_urls = auth_settings.value.allowed_external_redirect_urls
      enabled                        = auth_settings.value.enabled
      token_refresh_extension_hours  = auth_settings.value.token_refresh_extension_hours
      token_store_enabled            = auth_settings.value.token_store_enabled
    }
  }

  dynamic "connection_string" {
    for_each = var.App_Service_Slot[count.index].connection_string != null ? var.App_Service_Slot[count.index].connection_string : []
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }

  }
  dynamic "logs" {
    for_each = var.App_Service_Slot[count.index].logs != null ? var.App_Service_Slot[count.index].logs : []
    content {
      detailed_error_messages_enabled = logs.value.detailed_error_messages_enabled
      failed_request_tracing_enabled  = logs.value.failed_request_tracing_enabled

      dynamic "application_logs" {
        for_each = logs.value.application_logs != null ? logs.value.application_logs : []
        content {
          file_system_level = application_logs.value.file_system_level
          dynamic "azure_blob_storage" {
            for_each = application_logs.value.azure_blob_storage != null ? application_logs.value.azure_blob_storage : []
            content {
              level             = azure_blob_storage.value.level
              retention_in_days = azure_blob_storage.value.retention_in_days
              sas_url           = azure_blob_storage.value.sas_url
            }
          }
        }

      }

      dynamic "http_logs" {
        for_each = logs.value.http_logs != null ? logs.value.http_logs : []
        content {
          dynamic "file_system" {
            for_each = http_logs.value.file_system != null ? http_logs.value.file_system : []
            content {
              retention_in_days = file_system.value.retention_in_days
              retention_in_mb   = file_system.value.retention_in_mb
            }

          }
        }

      }
    }

  }

  dynamic "site_config" {
    for_each = var.App_Service_Slot[count.index].site_config != null ? var.App_Service_Slot[count.index].site_config : []
    content {
      acr_use_managed_identity_credentials = try(site_config.value.acr_use_managed_identity_credentials, null)
      acr_user_managed_identity_client_id  = try(site_config.value.acr_user_managed_identity_client_id, null)
      always_on                            = try(site_config.value.always_on, null)
      app_command_line                     = try(site_config.value.app_command_line, null)
      auto_swap_slot_name                  = try(site_config.value.auto_swap_slot_name, null)
      default_documents                    = try(site_config.value.default_documents, null)
      dotnet_framework_version             = try(site_config.value.dotnet_framework_version, null)
      ftps_state                           = try(site_config.value.ftps_state, null)
      health_check_path                    = try(site_config.value.health_check_path, null)
      number_of_workers                    = try(site_config.value.number_of_workers, null)
      http2_enabled                        = try(site_config.value.http2_enabled, null)
      scm_use_main_ip_restriction          = try(site_config.value.scm_use_main_ip_restriction, null)
      java_version                         = try(site_config.value.java_version, null)
      java_container                       = try(site_config.value.java_container, null)
      java_container_version               = try(site_config.value.java_container_version, null)
      local_mysql_enabled                  = try(site_config.value.local_mysql_enabled, null)
      linux_fx_version                     = try(site_config.value.linux_fx_version, null)
      windows_fx_version                   = try(site_config.value.windows_fx_version, null)
      managed_pipeline_mode                = try(site_config.value.managed_pipeline_mode, null)
      min_tls_version                      = try(site_config.value.min_tls_version, null)
      php_version                          = try(site_config.value.php_version, null)
      python_version                       = try(site_config.value.python_version, null)
      remote_debugging_enabled             = try(site_config.value.remote_debugging_enabled, null)
      remote_debugging_version             = try(site_config.value.remote_debugging_version, null)
      scm_type                             = try(site_config.value.scm_type, null)
      use_32_bit_worker_process            = try(site_config.value.use_32_bit_worker_process, null)
      vnet_route_all_enabled               = try(site_config.value.vnet_route_all_enabled, null)
      websockets_enabled                   = try(site_config.value.websockets_enabled, null)

      dynamic "ip_restriction" {
        for_each = site_config.value.ip_restriction != null ? site_config.value.ip_restriction : []
        content {
          action     = ip_restriction.value.action
          headers    = ip_restriction.value.headers
          ip_address = ip_restriction.value.ip_address
          name       = ip_restriction.value.name
          priority   = ip_restriction.value.priority
        }
      }

      dynamic "scm_ip_restriction" {
        for_each = site_config.value.scm_ip_restriction != null ? site_config.value.scm_ip_restriction : []
        content {
          ip_address                = scm_ip_restriction.value.ip_address
          service_tag               = scm_ip_restriction.value.service_tag
          virtual_network_subnet_id = scm_ip_restriction.value.virtual_network_subnet_id
          name                      = scm_ip_restriction.value.name
          priority                  = scm_ip_restriction.value.priority
          action                    = scm_ip_restriction.value.action
          headers                   = scm_ip_restriction.value.headers
        }
      }
    }
  }
}
