terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0"
      }
    }
    required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "random_integer" "simple_integer" {
  min = 10000
  max = 99999
}

resource "random_string" "simple_string" {
  length = 8
  special = false
  upper = false
}

resource "azurerm_resource_group" "simple_table_rg" {
  name = "SimpleTableRG"
  location = "WestEurope"
}

resource "azurerm_storage_account" "simple_storage_account" {
  name = "simpletable${resource.random_integer.simple_integer.result}"
  resource_group_name = azurerm_resource_group.simple_table_rg.name
  location = azurerm_resource_group.simple_table_rg.location
  account_tier = "Standard"
  account_replication_type = "LRS" # use ZRS or GRS for production
  min_tls_version = "TLS1_2"
  tags = {
    Environment = "Development"
  }
}

resource "azurerm_storage_table" "pizza_table" {
  name = "simplepizza${random_string.simple_string.result}"
  storage_account_name = azurerm_storage_account.simple_storage_account.name
}
