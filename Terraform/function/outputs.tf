output "resource_group_name" {
  value = azurerm_resource_group.func_rg.name
}
output "storage_account_name" {
  value = azurerm_storage_account.func_store.name
}
output "service_plan_id" {
  value = azurerm_service_plan.linux_service_plan.id
}

output "linux_function_app_id" {
  value = azurerm_linux_function_app.node_linux_func.id
}
