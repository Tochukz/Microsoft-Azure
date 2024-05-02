resource "random_integer" "int" {
  min = 1000
  max = 9999
}

locals {
  admin_user = "simple-user-${random_integer.int.id}"
}

resource "azurerm_resource_group" "simple_rg" {
  name     = "serverless-${random_integer.int.id}-rg"
  location = var.location
}

resource "azurerm_mssql_server" "db_server" {
  name                         = "simple-db-server"
  resource_group_name          = azurerm_resource_group.simple_rg.name
  location                     = azurerm_resource_group.simple_rg.location
  version                      = "12.0"
  administrator_login          = local.admin_user
  administrator_login_password = var.db_password
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "serverless_db" {
  name                        = "simple-serverless-db"
  server_id                   = azurerm_mssql_server.db_server.id
  sku_name                    = "GP_S_Gen5_1" # General Purpose, Serverless, 1 vCore
  auto_pause_delay_in_minutes = 60
  min_capacity                = 0.5
  max_size_gb                 = 3
  geo_backup_enabled          = false
  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_mssql_firewall_rule" "remote_access" {
  name             = "simple-remote-access"
  server_id        = azurerm_mssql_server.db_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
  # Allows any IP address to connect
}
