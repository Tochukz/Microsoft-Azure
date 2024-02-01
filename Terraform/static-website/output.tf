output "api_key" {
  value     = azurerm_static_site.simple_site.api_key
  sensitive = true
}
output "default_host_name" {
  value = azurerm_static_site.simple_site.default_host_name
}
