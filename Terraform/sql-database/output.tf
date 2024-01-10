output "resource_group_name" {
  value = azurerm_resource_group.sql_rg.name
}

output "sql_server_name" {
  value = azurerm_mssql_server.server.name
}

output "sql_server_domain_name" {
  value = azurerm_mssql_server.server.fully_qualified_domain_name
}
output "admin_password" {
  sensitive = true
  value     = local.admin_password
}
