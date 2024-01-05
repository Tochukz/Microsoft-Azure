output "profile_id" {
  value = azurerm_cdn_profile.profile.id
}

output "resource_group_name" {
  value = azurerm_resource_group.cdn_rg.name
}

output "cdn_profile_name" {
  value = azurerm_cdn_profile.profile.name
}

output "endpoint_name" {
  value = azurerm_cdn_endpoint.endpoint.name
}

output "cdn_endpoint_fqdn" {
  value = azurerm_cdn_endpoint.endpoint.fqdn
}

output "primary_web_host" {
  value = azurerm_storage_account.cdn_store.primary_web_host
}

output "storage_account_name" {
  value = azurerm_storage_account.cdn_store.name
}
