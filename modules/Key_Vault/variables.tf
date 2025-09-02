variable "Key_Vault" {
  type = list(object({
    access_policy = list(object({
      application_id          = string
      certificate_permissions = list(string)
      key_permissions         = list(string)
      object_id               = string
      secret_permissions      = list(string)
      storage_permissions     = list(string)
      tenant_id               = string
    }))
    location                   = string
    name                       = string
    resource_group             = string
    sku_name                   = string
    soft_delete_retention_days = number
    tags                       = map(string)
    tenant_id                  = string
    network_acls = list(object({
      bypass                     = string
      default_action             = string
      ip_rules                   = list(string)
      virtual_network_subnet_ids = list(string)
    }))
  }))
  description = "List Of Key Vault"

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