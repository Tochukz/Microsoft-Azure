terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
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
  name = "SimpleRG${random_integer.simple_int.result}"
  location = var.location
}

resource "azurerm_service_plan" "simple_sp" {
  name = "WebAppASP${random_integer.simple_int.result}"
  resource_group_name = azurerm_resource_group.simple_rg.name 
  location =  azurerm_resource_group.simple_rg.location
  os_type = "Linux" 
  sku_name = "B1"
}

resource "azurerm_linux_web_app" "simple_webapp" {
  name = "SimpleWebApp${random_integer.simple_int.result}" 
  resource_group_name = azurerm_resource_group.simple_rg.name
  location = azurerm_resource_group.simple_rg.location
  service_plan_id = azurerm_service_plan.simple_sp.id
  https_only = true 
  
  app_settings = {
    PORT = 80
    NODE_ENV = var.node_env
  }
  site_config {
    app_command_line = "npm start"
    minimum_tls_version = "1.2"
    application_stack {
      node_version = "16-lts"
    }
    cors {
      allowed_origins = [ "http://localhost" ]
     # support_credentials = true
    }
  }
  
  tags = {
    DEPLOY_ENV = var.node_env    
  }
}

resource "azurerm_app_service_source_control" "code_source" {
  app_id = azurerm_linux_web_app.simple_webapp.id
  repo_url = "https://github.com/Tochukz/simple-express"
  branch = "master"
  use_manual_integration = true 
  use_mercurial = false
}