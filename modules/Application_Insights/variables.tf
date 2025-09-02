variable "Application_Insights" {
  type = list(object({
    application_type = string
    location         = string
    name             = string
    tags             = map(string)
    workspace_id     = string
    resource_group   = string
  }))
  description = "List Of Application Insights "

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