resource "azurerm_virtual_network" "vnet_list" {
  count               = length(var.VNET)
  address_space       = var.VNET[count.index].address_space
  location            = var.VNET[count.index].location
  name                = "${var.region_mapping[var.VNET[count.index].location]}-${var.environment_name}-${var.VNET[count.index].name}-${var.service_type}"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.VNET[count.index].resource_group]]


  tags = merge(
    var.VNET[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.VNET[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}

resource "azurerm_nat_gateway" "nat_gateway_list" {
  count               = length(var.Nat_Gateway)
  location            = var.Nat_Gateway[count.index].location
  name                = "${var.region_mapping[var.Nat_Gateway[count.index].location]}-${var.environment_name}-${var.Nat_Gateway[count.index].name}-${var.service_type}-ngw"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Nat_Gateway[count.index].resource_group]]
  sku_name            = var.Nat_Gateway[count.index].sku_name
  tags = merge(
    var.Nat_Gateway[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.Nat_Gateway[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}


resource "azurerm_network_security_group" "network_security_group_list" {
  count               = length(var.NSG)
  location            = var.NSG[count.index].location
  name                = "${var.region_mapping[var.NSG[count.index].location]}-${var.environment_name}-${var.NSG[count.index].name}-${var.service_type}-nsg"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.NSG[count.index].resource_group]]
  dynamic "security_rule" {
    for_each = var.NSG[count.index].security_rule
    content {
      access                                     = security_rule.value.access
      description                                = security_rule.value.description
      destination_address_prefix                 = security_rule.value.destination_address_prefix
      destination_address_prefixes               = security_rule.value.destination_address_prefixes
      destination_application_security_group_ids = security_rule.value.destination_application_security_group_ids
      destination_port_range                     = security_rule.value.destination_port_range
      destination_port_ranges                    = security_rule.value.destination_port_ranges
      direction                                  = security_rule.value.direction
      name                                       = security_rule.value.name
      priority                                   = security_rule.value.priority
      protocol                                   = security_rule.value.protocol
      source_address_prefix                      = security_rule.value.source_address_prefix
      source_address_prefixes                    = security_rule.value.source_address_prefixes
      source_application_security_group_ids      = security_rule.value.source_application_security_group_ids
      source_port_range                          = security_rule.value.source_port_range
      source_port_ranges                         = security_rule.value.source_port_ranges
    }
  }
  tags = merge(
    var.NSG[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.NSG[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}


resource "azurerm_private_dns_zone" "private_dns_zone_list" {
  count               = length(var.Private_Dns_Zone)
  name                = "${var.environment_name}-${var.Private_Dns_Zone[count.index].name}-${var.service_type}-pdz"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Private_Dns_Zone[count.index].resource_group]]

  tags = merge(
    var.Private_Dns_Zone[count.index].tags,
    {
      "env" = var.environment_name
    }
  )

  dynamic "soa_record" {
    for_each = var.Private_Dns_Zone[count.index].soa_record != null ? var.Private_Dns_Zone[count.index].soa_record : []
    content {
      email        = soa_record.value.email
      expire_time  = soa_record.value.expire_time
      minimum_ttl  = soa_record.value.minimum_ttl
      refresh_time = soa_record.value.refresh_time
      retry_time   = soa_record.value.retry_time
      ttl          = soa_record.value.ttl
    }
  }
}

resource "azurerm_private_endpoint" "private_endpoint_list" {
  count               = length(var.Private_Endpoint)
  location            = var.Private_Endpoint[count.index].location
  name                = "${var.region_mapping[var.Private_Endpoint[count.index].location]}-${var.environment_name}-${var.Private_Endpoint[count.index].name}-${var.service_type}-pe"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Private_Endpoint[count.index].resource_group]]
  subnet_id           = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[var.resource_group_mapping[var.Private_Endpoint[count.index].resource_group]]}/providers/Microsoft.Network/virtualNetworks/${var.Private_Endpoint[count.index].subnet_id.vnet_name}/subnets/${var.Private_Endpoint[count.index].subnet_id.subnet_name}"
  tags = merge(
    var.Private_Endpoint[count.index].tags,
    {
      "env" = var.environment_name

      "tr:environment-type" = upper(var.environment_name)
    }
  )
  dynamic "private_dns_zone_group" {
    for_each = var.Private_Endpoint[count.index].private_dns_zone_group != null ? var.Private_Endpoint[count.index].private_dns_zone_group : []
    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = formatlist("/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[var.resource_group_mapping[var.Private_Endpoint[count.index].resource_group]]}/providers/Microsoft.Network/privateDnsZones/%s", private_dns_zone_group.value.private_dns_zone_ids)
    }
  }

  dynamic "private_service_connection" {
    for_each = var.Private_Endpoint[count.index].private_service_connection
    content {
      is_manual_connection           = private_service_connection.value.is_manual_connection
      name                           = private_service_connection.value.name
      private_connection_resource_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_names[var.resource_group_mapping[var.Private_Endpoint[count.index].resource_group]]}/providers/${private_service_connection.value.private_connection_resource_id}"
      subresource_names              = private_service_connection.value.subresource_names
    }
  }
}

resource "azurerm_public_ip_prefix" "public_ip_prefix_list" {
  count               = length(var.Public_Ip_Prefix)
  location            = var.Public_Ip_Prefix[count.index].location
  prefix_length       = var.Public_Ip_Prefix[count.index].prefix_length
  name                = "${var.region_mapping[var.Public_Ip_Prefix[count.index].location]}-${var.environment_name}-${var.Public_Ip_Prefix[count.index].name}-${var.service_type}-pip"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Public_Ip_Prefix[count.index].resource_group]]
  sku                 = var.Public_Ip_Prefix[count.index].sku
  tags = merge(
    var.Public_Ip_Prefix[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.Public_Ip_Prefix[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}

resource "azurerm_subnet" "subnet_list" {
  depends_on           = [azurerm_virtual_network.vnet_list]
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  resource_group_name  = var.subnets[count.index].resource_group_name
  virtual_network_name = var.subnets[count.index].virtual_network_name
  address_prefixes     = var.subnets[count.index].address_prefixes
  service_endpoints    = try(var.subnets[count.index].service_endpoints, null)
}