output "resource_group_id" {
  value = azurerm_resource_group.simple_table_rg.id
}
output "storage_account_id" {
  value = azurerm_storage_account.simple_storage_account.id
}
output "table_id" {
  value = azurerm_storage_table.pizza_table.id
}
