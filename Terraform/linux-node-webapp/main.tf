terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
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
  name     = "SimpleRG${random_integer.simple_int.result}"
  location = var.location
}

resource "azurerm_service_plan" "simple_sp" {
  name                = "WebAppASP${random_integer.simple_int.result}"
  resource_group_name = azurerm_resource_group.simple_rg.name
  location            = azurerm_resource_group.simple_rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "simple_webapp" {
  name                = "SimpleWebApp${random_integer.simple_int.result}"
  resource_group_name = azurerm_resource_group.simple_rg.name
  location            = azurerm_resource_group.simple_rg.location
  service_plan_id     = azurerm_service_plan.simple_sp.id
  https_only          = true

  app_settings = {
    PORT     = 80
    NODE_ENV = var.node_env
  }
  site_config {
    health_check_path   = "/users"
    app_command_line    = "npm run start:prod"
    minimum_tls_version = "1.2"
    application_stack {
      node_version = "16-lts"
    }
    cors {
      allowed_origins = ["http://localhost"]
      # support_credentials = true
    }
  }

  logs {
    detailed_error_messages = true
    failed_request_tracing  = true

    application_logs {
      file_system_level = "Error"
    }

    http_logs {
    }
  }

  tags = {
    DEPLOY_ENV = var.node_env
  }
}

# Optional resource, may be omitted. If provided, will deploy code from the repo to the webapp.
resource "azurerm_app_service_source_control" "code_source" {
  app_id                 = azurerm_linux_web_app.simple_webapp.id
  repo_url               = "https://github.com/Tochukz/simple-express"
  branch                 = "master"
  use_manual_integration = true
  use_mercurial          = false
}


resource "azurerm_storage_account" "simple_storage" {
  name                     = "simplestore${random_integer.simple_int.result}"
  resource_group_name      = azurerm_resource_group.simple_rg.name
  location                 = azurerm_resource_group.simple_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_log_analytics_workspace" "simple_analytics" {
  name                = "WebAnalytics${random_integer.simple_int.result}"
  resource_group_name = azurerm_resource_group.simple_rg.name
  location            = azurerm_resource_group.simple_rg.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "simple_monitor" {
  name               = "simplemonitor${random_integer.simple_int.result}"
  target_resource_id = azurerm_linux_web_app.simple_webapp.id
  # storage_account_id = azurerm_storage_account.simple_storage.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.simple_analytics.id
  log {
    category = "AppServiceAppLogs"
    enabled  = true
  }
  log {
    category = "AppServiceHTTPLogs"
    enabled  = true
  }
  log {
    category = "AppServiceConsoleLogs"
    enabled  = true
  }
  log {
    category = "AppServicePlatformLogs"
    enabled  = true
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
