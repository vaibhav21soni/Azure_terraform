variable "SQL_Server" {
  type = list(object({
    administrator_login          = string
    administrator_login_password = string
    location                     = string
    name                         = string
    version                      = string
    tags                         = map(string)
    resource_group               = string
  }))
  description = "List of SQL Server "

}
variable "SQL_Database" {
  type = list(object({
    edition        = string
    location       = string
    max_size_bytes = number
    name           = string
    server_name    = string
    tags           = map(string)
    resource_group = string
  }))
  description = "List of SQL Database"

}
variable "Redis_Cache" {
  type = list(object({
    capacity            = number
    family              = string
    location            = string
    name                = string
    sku_name            = string
    tags                = map(string)
    redis_configuration = list(map(string))
    resource_group      = string
  }))
  description = "List of Redis cache "

}
variable "Elastic_Job_Agent" {
  type = list(object({
    location    = string
    name        = string
    database_id = map(string)
    tags        = map(string)
  }))
  description = "Elastic Job Agent List"
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

