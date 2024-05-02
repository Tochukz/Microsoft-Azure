output "sql_server_host" {
  value = azurerm_mssql_server.db_server.fully_qualified_domain_name
}
output "admin_user" {
  value = local.admin_user
}

