output "resource_group_name" {
  value = azurerm_resource_group.simple_rg.name
}
output "web_app_name" {
  value = azurerm_windows_web_app.simple_webapp.name
}
output "default_hostname" {
  value = azurerm_windows_web_app.simple_webapp.default_hostname
}
