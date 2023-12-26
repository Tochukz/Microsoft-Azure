terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {

  }
}

data "azurerm_client_config" "simple_client" {
}

resource "random_string" "simple_string" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "simple_queue_rg" {
  name     = "SimpleQueueRG"
  location = "westeurope"
}

resource "azurerm_storage_account" "simple_storage_account" {
  name                     = "simplequeue${random_string.simple_string.id}"
  resource_group_name      = azurerm_resource_group.simple_queue_rg.name
  location                 = azurerm_resource_group.simple_queue_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS" # use ZRS or GRS for production
  min_tls_version          = "TLS1_2"
  tags = {
    Environment = "Development"
  }
}

resource "azurerm_storage_queue" "simple_queue" {
  name                 = "simple-queue"
  storage_account_name = azurerm_storage_account.simple_storage_account.name
}

resource "azurerm_role_assignment" "simple_role_assign" {
  principal_id         = data.azurerm_client_config.simple_client.object_id
  role_definition_name = "Storage Queue Data Contributor"
  scope                = azurerm_storage_account.simple_storage_account.id
}
