output "resource_group_name" {
  value = azurerm_resource_group.simple_rg.name
}
output "web_app_name" {
  value = azurerm_linux_web_app.simple_webapp.name
}
output "defalt_hostname" {
  value = azurerm_linux_web_app.simple_webapp.default_hostname
}
