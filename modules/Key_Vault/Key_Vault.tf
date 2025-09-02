resource "azurerm_key_vault" "Key_Vault" {
  count               = length(var.Key_Vault)
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Key_Vault[count.index].resource_group]]
  name                = "${var.region_mapping[var.Key_Vault[count.index].location]}-${var.environment_name}-${var.Key_Vault[count.index].name}-${var.service_type}"
  location            = var.Key_Vault[count.index].location
  sku_name            = var.Key_Vault[count.index].sku_name
  tenant_id           = var.Key_Vault[count.index].tenant_id

  soft_delete_retention_days = try(var.Key_Vault[count.index].soft_delete_retention_days, null)

  access_policy = try(var.Key_Vault[count.index].access_policy, null)

  tags = merge(
    var.Key_Vault[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.Key_Vault[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )

  dynamic "network_acls" {
    for_each = var.Key_Vault[count.index].network_acls
    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = formatlist("/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[var.resource_group_mapping[var.Key_Vault[count.index].resource_group]]}/providers/Microsoft.Network/virtualNetworks/%s", network_acls.value.virtual_network_subnet_ids)
    }
  }
}