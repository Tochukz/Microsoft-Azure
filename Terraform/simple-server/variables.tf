variable "location" { 
  type = string
  description = "Azure region to deploy the resource"
  default = "westeurope"
}
variable "resource_group_prefix" {
  type = string
  description = "Prefix for the resource group"
  default = "simple-rg"
}
variable "username" {
  type = string
  description = "The username for the Linux VM"
  default = "azureadmin"
}