output "resource_group_id" {
  value = azurerm_resource_group.simple_rg.id
}
output "web_ip_address" {
  value = azurerm_linux_virtual_machine.web_linux_vm.public_ip_address
}
output "remote_ip_address" {
  value = azurerm_linux_virtual_machine.remove_linux_vm.public_ip_address
}
