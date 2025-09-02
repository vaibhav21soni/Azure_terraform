variable "Managed_Identities" {
  type = list(object({
    location       = string
    name           = string
    resource_group = string
    tags           = map(string)
  }))
  description = "Lists of Assigned Identity"

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