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

    tags       = map(string)
    delegation = list(map(string))
    hostname_configuration = list(object({
      proxy = map(string)
    }))
    sign_in = list(map(string))
    sign_up = list(object({
      enabled          = bool,
      terms_of_service = map(string)
    }))
  }))


  description = "List of Api Management Console"

}

variable "api_connection_details" {
  type = list(object({
    display_name   = string,
    name           = string,
    resource_group = string
    tags           = map(string)
  }))

  description = "SQL API Connections"


}

variable "subscription_id" {
  type        = string
  description = "Subscription string for the account"
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

variable "resource_group_mapping" {
  type        = map(string)
  description = "List of resource group mapping to be applied"
}