terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }

  }
  required_version = ">= 1.1.0"
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate9204"
    container_name       = "tfstate"
    key                  = "remote-state/terraform.tfstate"
  }
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "simple_rg" {
  name     = "simple-rg"
  location = "westeurope"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "simple-vnet"
  resource_group_name = azurerm_resource_group.simple_rg.name
  location            = azurerm_resource_group.simple_rg.location
  address_space       = ["10.0.0.0/16"]
}
