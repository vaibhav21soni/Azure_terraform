variable "Logic_App_Workflow_List" {
  type = list(object({
    enabled             = bool
    location            = string
    name                = string
    parameters          = map(string)
    tags                = map(string)
    workflow_parameters = map(string)
    workflow_schema     = string
    workflow_version    = string
    resource_group      = string
  }))

  description = "Logic App Workflow List"

}

variable "Logic_App_Trigger_Recurrence_List" {
  type = list(object({
    frequency    = string
    interval     = number
    logic_app_id = string
    name         = string
    time_zone    = string
  }))
  description = "Logic App Trigger List"

}


variable "Logic_App_Action_Custom_List" {
  type = list(object({
    body = string

    logic_app_id = string
    name         = string
  }))
  description = "List of Logic App Actions"

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