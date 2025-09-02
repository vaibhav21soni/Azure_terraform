output "resource_group_names" {
  description = "Names of created resource groups"
  value       = module.Resource_Group.resource_group_list_name
}

output "key_vault_ids" {
  description = "IDs of created Key Vaults"
  value       = try(module.Key_Vault.key_vault_ids, [])
}

output "storage_account_names" {
  description = "Names of created storage accounts"
  value       = try(module.Storage_Accounts.storage_account_names, [])
}

output "app_service_urls" {
  description = "URLs of created App Services"
  value       = try(module.App_Service.app_service_urls, [])
}

output "function_app_names" {
  description = "Names of created Function Apps"
  value       = try(module.Function_app.function_app_names, [])
}

output "sql_server_names" {
  description = "Names of created SQL Servers"
  value       = try(module.SQL_Server.sql_server_names, [])
}

output "virtual_network_ids" {
  description = "IDs of created Virtual Networks"
  value       = try(module.Networking.virtual_network_ids, [])
}

output "application_insights_ids" {
  description = "IDs of created Application Insights"
  value       = try(module.Application_Insights.application_insights_ids, [])
}

output "log_analytics_workspace_ids" {
  description = "IDs of created Log Analytics Workspaces"
  value       = try(module.Log_Analytics_Workspace.workspace_ids, [])
}

output "service_bus_namespace_ids" {
  description = "IDs of created Service Bus Namespaces"
  value       = try(module.Service_Bus.namespace_ids, [])
}
