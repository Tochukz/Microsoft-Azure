output "resource_group_name" {
  value = azurerm_resource_group.func_rg.name
}
output "storage_account_name" {
  value = azurerm_storage_account.func_store.name
}
output "linux_function_app_name" {
  value = azurerm_linux_function_app.node_linux_func.name
}
output "default_host_name" {
  value = azurerm_linux_function_app.node_linux_func.default_hostname
}
