# SQL Server Module

Creates Azure SQL Server and databases with security configurations.

## Purpose
- Managed relational database service
- High availability and scalability
- Enterprise-grade security features

## Resources Created
- `azurerm_mssql_server` - SQL Server instance
- `azurerm_mssql_database` - SQL databases
- `azurerm_mssql_firewall_rule` - Firewall rules
- `azurerm_mssql_server_security_alert_policy` - Security policies

## Usage
```hcl
module "sql_server" {
  source = "../modules/SQL_Server"
  
  SQL_Server             = var.SQL_Server
  resource_group_names   = module.Resource_Group.resource_group_list_name
  resource_group_mapping = var.resource_group_mapping
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["SQL_Server"]
  environment_name      = var.environment_mapping[var.env_name]
}
```

## Features
- Automated backups
- Point-in-time restore
- Transparent data encryption
- Advanced threat protection
- Elastic pools
- Read replicas
- Private endpoint connectivity
