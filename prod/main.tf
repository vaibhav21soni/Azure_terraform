terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.59.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "<backend-resource-group>"
    storage_account_name = "<backend-storage-account>"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "Resource_Group" {
  source           = "../modules/Resource_Group"
  Resource_Group   = var.Resource_Group
  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["Resource_Group"]
  environment_name = var.environment_mapping[var.env_name]
}

module "Key_Vault" {
  depends_on = [module.Resource_Group, module.Networking]
  source     = "../modules/Key_Vault"
  Key_Vault  = var.Key_Vault

  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["Key_Vault"]
  environment_name = var.environment_mapping[var.env_name]
  subscription_id  = var.subscription_id
}

module "Api_Management_Console" {
  depends_on = [
    module.Key_Vault,
    module.Resource_Group,
    module.Networking
  ]
  source                 = "../modules/Api_Management_Console"
  api_management_console = var.api_management_console_list

  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["Api_Management_Console"]
  environment_name = var.environment_mapping[var.env_name]
}

module "Managed_Identities" {
  depends_on = [module.Resource_Group]
  source     = "../modules/Managed_Identities"

  Managed_Identities     = var.Managed_Identities
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["Managed_Identities"]
  environment_name = var.environment_mapping[var.env_name]
}

module "Networking" {
  depends_on = [module.Resource_Group]
  source     = "../modules/Networking"

  Virtual_Network        = var.VNET
  subnets                = var.subnets
  Nat_Gateway            = var.Nat_Gateway
  NSG                    = var.NSG
  Private_Dns_Zone       = var.Private_Dns_Zone
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["Virtual_Network"]
  environment_name = var.environment_mapping[var.env_name]
}

module "Storage_Accounts" {
  depends_on = [module.Resource_Group]
  source     = "../modules/Storage_Accounts"

  Storage_Accounts       = var.Storage_Accounts
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["Storage_Accounts"]
  environment_name = var.environment_mapping[var.env_name]
}

module "App_Service_Plan" {
  depends_on = [module.Resource_Group]
  source     = "../modules/App_Service_Plan"

  App_Service_Plan_List  = var.App_Service_Plan_List
  Service_Plan_List      = var.Service_Plan_List
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["App_Service_Plan"]
  environment_name = var.environment_mapping[var.env_name]
}

module "App_Service" {
  depends_on = [
    module.Resource_Group,
    module.App_Service_Plan,
    module.Storage_Accounts,
    module.Networking
  ]
  source = "../modules/App_Service"

  App_Service            = var.App_Service
  App_Service_Slot       = var.App_Service_Slot
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["App_Service"]
  environment_name = var.environment_mapping[var.env_name]
}

module "Function_app" {
  depends_on = [
    module.Resource_Group,
    module.App_Service_Plan,
    module.Storage_Accounts,
    module.Networking
  ]
  source = "../modules/Function_app"

  Function_App_List      = var.Function_App_List
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["Function_App"]
  environment_name = var.environment_mapping[var.env_name]
}

module "SQL_Server" {
  depends_on = [module.Resource_Group]
  source     = "../modules/SQL_Server"

  SQL_Server             = var.SQL_Server
  SQL_DB                 = var.SQL_DB
  Redis_Cache            = var.Redis_Cache
  Elastic_Job_Agent      = var.Elastic_Job_Agent
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["SQL_Server"]
  environment_name = var.environment_mapping[var.env_name]
}

module "SQL_Replica_Server" {
  depends_on = [module.Resource_Group, module.SQL_Server]
  source     = "../modules/SQL_Replica_Server"

  SQL_Server_Replica     = var.SQL_Server_Replica
  Replica_SQL_DB         = var.Replica_SQL_DB
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["SQL_Replica_Server"]
  environment_name = var.environment_mapping[var.env_name]
}

module "Service_Bus" {
  depends_on = [module.Resource_Group]
  source     = "../modules/Service_Bus"

  Service_Bus_Namespace  = var.Service_Bus_Namespace
  Service_Bus_Topic      = var.Service_Bus_Topic
  Queue_List             = var.Queue_List
  Subscription_List      = var.Subscription_List
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["Service_Bus"]
  environment_name = var.environment_mapping[var.env_name]
}

module "Application_Insights" {
  depends_on = [module.Resource_Group, module.Log_Analytics_Workspace]
  source     = "../modules/Application_Insights"

  Application_Insights   = var.Application_Insights
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["Application_Insights"]
  environment_name = var.environment_mapping[var.env_name]
}

module "Log_Analytics_Workspace" {
  depends_on = [module.Resource_Group]
  source     = "../modules/Log_Analytics_Workspace"

  Log_Analytics_Workspace = var.Log_Analytics_Workspace
  resource_group_names    = module.Resource_Group.resource_group_list_name
  resource_group_mapping  = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["Log_Analytics_Workspace"]
  environment_name = var.environment_mapping[var.env_name]
}

module "Logic_Apps" {
  depends_on = [module.Resource_Group]
  source     = "../modules/Logic_Apps"

  Logic_App_Workflow_List           = var.Logic_App_Workflow_List
  Logic_App_Trigger_Recurrence_List = var.Logic_App_Trigger_Recurrence_List
  Logic_App_Action_Custom_List      = var.Logic_App_Action_Custom_List
  api_connection_details            = var.api_connection_details
  resource_group_names              = module.Resource_Group.resource_group_list_name
  resource_group_mapping            = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["Logic_Apps"]
  environment_name = var.environment_mapping[var.env_name]
}

module "Action_Group" {
  depends_on = [module.Resource_Group]
  source     = "../modules/Action_Group"

  Action_Group           = var.Action_Group
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping

  region_mapping   = var.region_mapping
  service_type     = var.service_type_mapping["Action_Group"]
  environment_name = var.environment_mapping[var.env_name]
}
