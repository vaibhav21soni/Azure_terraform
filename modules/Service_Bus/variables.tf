variable "Service_Bus_Namespace" {
  type = list(object({
    location       = string
    name           = string
    sku            = string
    capacity       = number
    tags           = map(string)
    resource_group = string
  }))
  description = "List of Service_Bus"
}

variable "Service_Bus_Topic" {
  type = list(object({
    max_message_size_in_kilobytes = number
    max_size_in_megabytes         = number
    name                          = string
    namespace_id                  = string
    status                        = string
  }))
  description = "List of Service_Bus_Topics"
}

variable "Queue_List" {
  type = list(object({
    max_delivery_count            = number
    max_message_size_in_kilobytes = number
    max_size_in_megabytes         = number
    name                          = string
    namespace_id                  = string
    status                        = string
  }))

  description = "List of queue to be added"
}

variable "Subscription_List" {
  type = list(object({
    max_delivery_count = number
    name               = string
    requires_session   = bool
    status             = string
    topic_id           = map(string)
  }))
  description = "List of subscriptions"
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


















