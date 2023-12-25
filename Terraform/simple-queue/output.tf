output "resource_group_id" {
  value = azurerm_resource_group.simple_queue_rg.id
}
output "storage_account_id" {
  value = azurerm_storage_account.simple_storage_account.id
}
output "queue_id" {
  value = azurerm_storage_queue.simple_queue.id
}
output "client_config_id" {
  value = data.azurerm_client_config.simple_client.object_id
}
