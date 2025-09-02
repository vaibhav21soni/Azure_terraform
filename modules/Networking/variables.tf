variable "VNET" {
  type = list(object({
    address_space  = list(string)
    location       = string
    name           = string
    resource_group = string
    tags           = map(string)
  }))
  description = "List of VNET"

}
variable "subnets" {
  type = list(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
    service_endpoints    = list(string)
  }))
  description = "List of Subnets"
}
variable "Nat_Gateway" {
  type = list(object({
    idle_timeout_in_minutes = number
    location                = string
    name                    = string
    resource_group          = string
    sku_name                = string
    tags                    = map(string)
  }))
  description = "List of Nat_Gateway"

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
  description = "List Of NSG"

}
variable "Private_Dns_Zone" {
  type = list(object({
    name           = string
    resource_group = string
    tags           = map(string)
    soa_record = list(object({
      email        = string
      expire_time  = number
      minimum_ttl  = number
      refresh_time = number
      retry_time   = number
      ttl          = number
    }))
  }))
  description = "List Of private DNS Zone"

}
variable "Private_Endpoint" {
  type = list(object({
    location       = string
    name           = string
    resource_group = string
    subnet_id      = map(string)
    tags           = map(string)
    private_dns_zone_group = list(object({
      name                 = string
      private_dns_zone_ids = list(string)
    }))
    private_service_connection = list(object({
      is_manual_connection           = string
      name                           = string
      private_connection_resource_id = string
      subresource_names              = list(string)
    }))
  }))
  description = "List of Private Endpoint"

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
  description = "List Of Public IP Prefix"

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

variable "resource_group_mapping" {
  type        = map(string)
  description = "List of resource group mapping to be applied"
}