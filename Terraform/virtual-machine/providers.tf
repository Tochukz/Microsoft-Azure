terraform {
  required_providers {
    azapi = {
      source = "azure/azapi"
      version = "~>1.2"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~>3.0"
    }
  }
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}