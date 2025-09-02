variable "SQL_Server_Replica" {
  type = list(object({
    administrator_login          = string
    administrator_login_password = string
    location                     = string
    name                         = string
    version                      = string
    tags                         = map(string)
    resource_group               = string
  }))
  description = "List of Replica SQL Server"

}
variable "Replica_SQL_DB" {
  type = list(object({
    edition        = string
    location       = string
    max_size_bytes = number
    name           = string
    server_name    = string
    tags           = map(string)
    resource_group = string
  }))
  description = "List Of Replica DB"

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