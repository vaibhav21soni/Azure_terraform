variable "Action_Group" {
  type = list(object({
    enabled        = bool
    location       = string
    name           = string
    resource_group = string
    short_name     = string

    email_receiver   = list(map(string))
    webhook_receiver = list(map(string))
  }))
  description = "List of action_group"

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