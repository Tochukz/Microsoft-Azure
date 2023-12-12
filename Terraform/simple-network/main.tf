terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "simple_rg" {
  name     = "SimpleResourceGroup"
  location = var.location
  tags = {
    Environment = "Development ResourceGroup" 
    Team = "DevOps"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name = "SimpleVNet" 
  address_space = ["10.0.0.0/16"]
  location = var.location
  resource_group_name = azurerm_resource_group.simple_rg.name
}