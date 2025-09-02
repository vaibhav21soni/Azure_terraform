# SQL Replica Server Module

Creates Azure SQL Server replicas for high availability and disaster recovery.

## Purpose
- Database high availability
- Disaster recovery planning
- Read-only workload distribution
- Geographic redundancy

## Resources Created
- `azurerm_mssql_server` - Replica SQL Server
- `azurerm_mssql_database` - Replica databases
- Failover group configurations
- Cross-region replication

## Usage
```hcl
module "sql_replica_server" {
  source = "../modules/SQL_Replica_Server"
  
  SQL_Replica_Server     = var.SQL_Replica_Server
  resource_group_names   = module.Resource_Group.resource_group_list_name
  region_mapping         = var.region_mapping
  service_type          = var.service_type_mapping["SQL_Replica_Server"]
  environment_name      = var.environment_mapping[var.env_name]
}
```

## Features
- Active geo-replication
- Auto-failover groups
- Read-scale replicas
- Cross-region backup
