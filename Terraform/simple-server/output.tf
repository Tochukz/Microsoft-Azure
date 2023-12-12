output "resource_group_name" {
  value = azurerm_resource_group.simple_rg.name
}
output "public_ip_address" {
  value = azurerm_linux_virtual_machine.simple_ubuntu.public_ip_address
}