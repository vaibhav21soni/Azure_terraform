resource "azurerm_sql_server" "SQL_Server" {
  count                        = length(var.SQL_Server)
  administrator_login          = var.SQL_Server[count.index].administrator_login
  administrator_login_password = var.SQL_Server[count.index].administrator_login_password
  location                     = var.SQL_Server[count.index].location
  name                         = "${var.region_mapping[var.SQL_Server[count.index].location]}-${var.environment_name}-${var.SQL_Server[count.index].name}-${var.service_type}srv"
  resource_group_name          = var.resource_group_names[var.resource_group_mapping[var.SQL_Server[count.index].resource_group]]
  version                      = var.SQL_Server[count.index].version

  tags = merge(
    var.SQL_Server[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.SQL_Server[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}

resource "azurerm_sql_database" "SQL_Database" {
  depends_on          = [azurerm_sql_server.SQL_Server]
  count               = length(var.SQL_Database)
  edition             = var.SQL_Database[count.index].edition
  location            = var.SQL_Database[count.index].location
  name                = "${var.region_mapping[var.SQL_Database[count.index].location]}-${var.environment_name}-${var.SQL_Database[count.index].name}-${var.service_type}-db"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.SQL_Database[count.index].resource_group]]
  server_name         = var.SQL_Database[count.index].server_name
  tags = merge(
    var.SQL_Database[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.SQL_Database[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}

resource "azurerm_redis_cache" "SQL_Redis_Cache" {
  count               = length(var.Redis_Cache)
  capacity            = var.Redis_Cache[count.index].capacity
  family              = var.Redis_Cache[count.index].family
  location            = var.Redis_Cache[count.index].location
  name                = "${var.region_mapping[var.Redis_Cache[count.index].location]}-${var.environment_name}-${var.Redis_Cache[count.index].name}-${var.service_type}-rds"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Redis_Cache[count.index].resource_group]]
  sku_name            = var.Redis_Cache[count.index].sku_name
  tags = merge(
    var.Redis_Cache[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.Redis_Cache[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )

  dynamic "redis_configuration" {
    for_each = try(var.Redis_Cache[count.index].redis_configuration != null, null) ? var.Redis_Cache[count.index].redis_configuration : null
    content {
      maxfragmentationmemory_reserved = try(redis_configuration.value.maxfragmentationmemory_reserved, null)
      maxmemory_delta                 = try(redis_configuration.value.maxmemory_delta, null)
      maxmemory_reserved              = try(redis_configuration.value.maxmemory_reserved, null)
      enable_authentication           = try(redis_configuration.value.enable_authentication, null)
      maxclients                      = try(redis_configuration.value.maxclients, null)
      maxmemory_policy                = try(redis_configuration.value.maxmemory_policy, null)
    }

  }

  lifecycle {
    ignore_changes = [
      redis_configuration
    ]
  }
}

resource "azurerm_mssql_job_agent" "Job_Agent" {
  depends_on  = [azurerm_sql_database.SQL_Database]
  count       = length(var.Elastic_Job_Agent)
  location    = var.Elastic_Job_Agent[count.index].location
  name        = "${var.region_mapping[var.Elastic_Job_Agent[count.index].location]}-${var.environment_name}-${var.Elastic_Job_Agent[count.index].name}-${var.service_type}-jobagent"
  database_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.Elastic_Job_Agent[count.index].database_id.resource_group_name}/providers/Microsoft.Sql/servers/${var.Elastic_Job_Agent[count.index].database_id.server_name}/databases/${var.Elastic_Job_Agent[count.index].database_id.db_name}"
  tags        = try(var.Elastic_Job_Agent[count.index].tags, false)
}