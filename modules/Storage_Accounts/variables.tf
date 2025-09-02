variable "storage_accounts" {

  type = list(object({
    account_replication_type = string
    account_tier             = string
    location                 = string
    name                     = string
    tags                     = map(string)
    resource_group           = string
    queue_properties = object({
      hour_metrics = list(map(string))
    })
  }))
  description = "List of storage accounts"
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