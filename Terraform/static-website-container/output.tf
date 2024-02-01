output "resource_group_name" {
  value = azurerm_resource_group.static_rg.name
}
output "storage_account_name" {
  value = azurerm_storage_account.static_store.name
}
output "primary_web_host" {
  value = azurerm_storage_account.static_store.primary_web_host
}
