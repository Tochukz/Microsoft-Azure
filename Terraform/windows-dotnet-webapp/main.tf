terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.8"
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "random_integer" "simple_int" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "simple_rg" {
  name     = "simplerg${random_integer.simple_int.result}"
  location = var.location
}

resource "azurerm_service_plan" "windows_plan" {
  name                = "simpleplan${random_integer.simple_int.result}"
  resource_group_name = azurerm_resource_group.simple_rg.name
  location            = azurerm_resource_group.simple_rg.location
  os_type             = "Windows"
  sku_name            = "B1"
  lifecycle {
    create_before_destroy = false
  }
}

resource "azurerm_windows_web_app" "simple_webapp" {
  name                = "windowsapp${random_integer.simple_int.result}"
  resource_group_name = azurerm_resource_group.simple_rg.name
  location            = azurerm_resource_group.simple_rg.location
  service_plan_id     = azurerm_service_plan.windows_plan.id
  https_only          = true

  app_settings = {

  }
  site_config {
    health_check_path   = "/users"
    minimum_tls_version = "1.2"
    application_stack {
      dotnet_version = "v7.0"
      current_stack  = "dotnetcore"
    }
    # application_stack {
    #   dotnet_version = "v7.0"
    #   current_stack  = "dotnet"
    # }
    cors {
      allowed_origins = ["http://localhost"]
      # support_credentials = true
    }
  }
}

