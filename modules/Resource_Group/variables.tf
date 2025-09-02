variable "Resource_Group" {
  type = list(object({
    location = string
    name     = string
    tags     = map(string)
  }))
  description = "List of Resource group"
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