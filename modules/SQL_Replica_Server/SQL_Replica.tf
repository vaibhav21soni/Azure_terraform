resource "azurerm_sql_server" "Replica_SQL_Server" {
  count                        = length(var.SQL_Server_Replica)
  administrator_login          = var.SQL_Server_Replica[count.index].administrator_login
  administrator_login_password = var.SQL_Server_Replica[count.index].administrator_login_password
  location                     = var.SQL_Server_Replica[count.index].location
  name                         = "${var.region_mapping[var.SQL_Server_Replica[count.index].location]}-${var.environment_name}-${var.SQL_Server_Replica[count.index].name}-${var.service_type}srv"
  resource_group_name          = var.resource_group_names[var.resource_group_mapping[var.SQL_Server_Replica[count.index].resource_group]]
  version                      = var.SQL_Server_Replica[count.index].version

  tags = merge(
    var.SQL_Server_Replica[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.SQL_Server_Replica[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}

resource "azurerm_sql_database" "Replica_SQL_DB" {
  depends_on          = [azurerm_sql_server.Replica_SQL_Server]
  count               = length(var.Replica_SQL_DB)
  edition             = var.Replica_SQL_DB[count.index].edition
  location            = var.Replica_SQL_DB[count.index].location
  name                = "${var.region_mapping[var.Replica_SQL_DB[count.index].location]}-${var.environment_name}-${var.Replica_SQL_DB[count.index].name}-${var.service_type}-db"
  resource_group_name = var.resource_group_names[var.resource_group_mapping[var.Replica_SQL_DB[count.index].resource_group]]
  server_name         = var.Replica_SQL_DB[count.index].server_name
  tags = merge(
    var.Replica_SQL_DB[count.index].tags,
    {
      "env"                 = var.environment_name
      "location"            = var.Replica_SQL_DB[count.index].location
      "tr:environment-type" = upper(var.environment_name)
    }
  )
}