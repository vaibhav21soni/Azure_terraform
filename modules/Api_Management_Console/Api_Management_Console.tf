resource "azurerm_api_connection" "sql" {
  count               = length(var.api_connection_details)
  managed_api_id      = "/subscriptions/${var.subscription_id}/providers/Microsoft.Web/locations/westus/managedApis/sql"
  name                = "${var.environment_name}-${var.api_connection_details[count.index].name}-${var.service_type}"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.api_connection_details[count.index].resource_group]]
  tags = merge(
    var.api_connection_details[count.index].tags,
    {
      "env"                 = var.environment_name
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}

resource "azurerm_api_management" "Api_Management_Console" {
  count               = length(var.api_management_console_list)
  location            = var.api_management_console_list[count.index].location
  name                = "${var.region_mapping[var.api_management_console_list[count.index].location]}-${var.environment_name}-${var.api_management_console_list[count.index].name}-${var.service_type}"
  publisher_email     = var.api_management_console_list[count.index].publisher_email
  publisher_name      = var.api_management_console_list[count.index].publisher_name
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.api_management_console_list[count.index].resource_group]]
  sku_name            = var.api_management_console_list[count.index].sku_name

  tags = merge(
    var.api_management_console_list[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.api_management_console_list[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )

  dynamic "delegation" {
    for_each = try(var.api_management_console_list[count.index].delegation != null, false) ? var.api_management_console_list[count.index].delegation : []
    content {
      subscriptions_enabled     = try(delegation.subscriptions_enabled, null)
      user_registration_enabled = try(delegation.user_registration_enabled, null)
      url                       = try(delegation.url, null)
      validation_key            = try(delegation.validation_key, null)
    }

  }

  dynamic "hostname_configuration" {
    for_each = try(var.api_management_console_list[count.index].hostname_configuration != null, false) ? var.api_management_console_list[count.index].hostname_configuration : []
    content {
      proxy {
        default_ssl_binding = hostname_configuration.value.proxy["default_ssl_binding"]
        host_name           = hostname_configuration.value.proxy["host_name"]
      }
    }
  }

  dynamic "sign_in" {
    for_each = try(var.api_management_console_list[count.index].sign_in != null, false) ? var.api_management_console_list[count.index].sign_in : []
    content {
      enabled = sign_in.value.enabled
    }
  }

  dynamic "sign_up" {
    for_each = try(var.api_management_console_list[count.index].sign_up != null, false) ? var.api_management_console_list[count.index].sign_up : []
    content {
      enabled = sign_up.value.enabled
      terms_of_service {
        consent_required = sign_up.value.terms_of_service.consent_required
        enabled          = sign_up.value.terms_of_service.enabled
      }
    }
  }
}