variable "App_Service_Plan_List" {
  type = list(object({
    location                     = string
    maximum_elastic_worker_count = number
    name                         = string
    reserved                     = bool
    kind                         = string
    resource_group               = string
    tags                         = map(string)
    sku                          = list(map(string))
  }))
  description = "List of App Service Plans"

}

variable "Service_Plan_List" {
  type = list(object({
    location                     = string
    maximum_elastic_worker_count = number
    name                         = string
    os_type                      = string
    per_site_scaling_enabled     = bool
    resource_group               = string
    sku_name                     = string
    tags                         = map(string)
    worker_count                 = number
    zone_balancing_enabled       = bool
    }
  ))
  description = "Service Plan List"

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
  description = "service_type"
}

variable "region_mapping" {
  type        = map(string)
  description = "Region_Mappings"
}

variable "resource_group_mapping" {
  type        = map(string)
  description = "List of resource group mapping to be applied"
}