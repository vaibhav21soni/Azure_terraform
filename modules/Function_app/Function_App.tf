resource "azurerm_function_app" "Function_App" {
  count                      = length(var.Function_App_List)
  app_service_plan_id        = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[var.resource_group_mapping[var.Function_App_List[count.index].resource_group]]}/providers/Microsoft.Web/serverfarms/${var.Function_App_List[count.index].app_service_plan_id}"
  location                   = var.Function_App_List[count.index].location
  name                       = "${var.region_mapping[var.Function_App_List[count.index].location]}-${var.environment_name}-${var.Function_App_List[count.index].name}-${var.service_type}"
  resource_group_name        = var.resource_group_names[var.resource_group_mapping[var.Function_App_List[count.index].resource_group]]
  storage_account_access_key = var.storage_accounts[var.Function_App_List[count.index].storage_account_name]
  storage_account_name       = var.Function_App_List[count.index].storage_account_name
  version                    = var.Function_App_List[count.index].version

  tags = merge(
    var.Function_App_List[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.Function_App_List[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"             = try(lookup(var.application_insight_list, var.Function_App_List[count.index].name, null) != null) ? lookup(var.application_insight_list, var.Function_App_List[count.index].name, null).APPINSIGHTS_INSTRUMENTATIONKEY : null
    "APPLICATIONINSIGHTS_CONNECTION_STRING"      = try(lookup(var.application_insight_list, var.Function_App_List[count.index].name, null) != null) ? lookup(var.application_insight_list, var.Function_App_List[count.index].name, null).APPLICATIONINSIGHTS_CONNECTION_STRING : null
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
  }


  dynamic "connection_string" {
    for_each = var.Function_App_List[count.index].connection_string != null ? var.Function_App_List[count.index].connection_string : []
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }

  }

  dynamic "identity" {
    for_each = var.Function_App_List[count.index].identity != null ? var.Function_App_List[count.index].identity : []
    content {

      identity_ids = formatlist("/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[var.resource_group_mapping[var.Function_App_List[count.index].resource_group]]}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/%s", identity.value.identity_ids)
      type         = identity.value.type
    }

  }

  dynamic "site_config" {
    for_each = var.Function_App_List[count.index].site_config != null ? var.Function_App_List[count.index].site_config : null
    content {
      always_on                        = site_config.value.always_on
      app_scale_limit                  = site_config.value.app_scale_limit
      dotnet_framework_version         = site_config.value.dotnet_framework_version
      elastic_instance_minimum         = site_config.value.elastic_instance_minimum
      ftps_state                       = site_config.value.ftps_state
      http2_enabled                    = site_config.value.http2_enabled
      min_tls_version                  = site_config.value.min_tls_version
      pre_warmed_instance_count        = site_config.value.pre_warmed_instance_count
      runtime_scale_monitoring_enabled = site_config.value.runtime_scale_monitoring_enabled
      scm_ip_restriction               = site_config.value.scm_ip_restriction
      scm_type                         = site_config.value.scm_type
      scm_use_main_ip_restriction      = site_config.value.scm_use_main_ip_restriction
      use_32_bit_worker_process        = site_config.value.use_32_bit_worker_process
      vnet_route_all_enabled           = site_config.value.vnet_route_all_enabled
      websockets_enabled               = site_config.value.websockets_enabled

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

      dynamic "cors" {
        for_each = site_config.value.cors != null ? site_config.value.cors : []
        content {
          allowed_origins     = cors.value.allowed_origins
          support_credentials = cors.value.support_credentials
        }
      }
    }
  }
}