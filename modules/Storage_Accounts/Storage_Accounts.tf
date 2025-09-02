resource "azurerm_storage_account" "strorage_accounts" {
  count                    = length(var.storage_accounts)
  account_replication_type = var.storage_accounts[count.index].account_replication_type
  account_tier             = var.storage_accounts[count.index].account_tier
  location                 = var.storage_accounts[count.index].location
  name                     = "${var.region_mapping[var.storage_accounts[count.index].location]}${lower(var.environment_name)}${var.storage_accounts[count.index].name}${var.service_type}"
  resource_group_name      = var.resource_group_names[var.resource_group_mapping[var.storage_accounts[count.index].resource_group]]

  tags = merge(
    var.storage_accounts[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.storage_accounts[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )

  dynamic "queue_properties" {
    for_each = try(var.storage_accounts[count.index].queue_properties != null) ? var.storage_accounts[count.index].queue_properties : {}
    content {
      dynamic "hour_metrics" {
        for_each = queue_properties.value
        content {
          enabled               = hour_metrics.value.enabled
          include_apis          = hour_metrics.value.include_apis
          retention_policy_days = hour_metrics.value.retention_policy_days
          version               = hour_metrics.value.version

        }
      }
    }


  }
}


output "storage_accounts" {
  value = {
    for prop in azurerm_storage_account.strorage_accounts :
    prop.name => prop.primary_access_key
  }
  description = "Map for storage account"
}