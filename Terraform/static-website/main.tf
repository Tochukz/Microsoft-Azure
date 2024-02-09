terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "random_integer" "group_no" {
  min = 1000
  max = 9999
}
resource "azurerm_resource_group" "site_rg" {
  name     = "rg${random_integer.group_no.id}"
  location = var.location
}

resource "azurerm_static_site" "simple_site" {
  name                = "site${random_integer.group_no.id}"
  resource_group_name = azurerm_resource_group.site_rg.name
  location            = azurerm_resource_group.site_rg.location
}
