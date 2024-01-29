resource "random_integer" "rand_int" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "func_rg" {
  name     = "funcs-rg-${random_integer.rand_int.result}"
  location = var.location
}

resource "azurerm_storage_account" "func_store" {
  name                     = "funcstore${random_integer.rand_int.result}"
  resource_group_name      = azurerm_resource_group.func_rg.name
  location                 = azurerm_resource_group.func_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_service_plan" "linux_service_plan" {
  name                = "funcplan${random_integer.rand_int.result}"
  resource_group_name = azurerm_resource_group.func_rg.name
  location            = azurerm_resource_group.func_rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_application_insights" "func_insight" {
  name                = "func-insight-${random_integer.rand_int.result}"
  resource_group_name = azurerm_resource_group.func_rg.name
  location            = azurerm_resource_group.func_rg.location
  application_type    = "Node.JS"
}

resource "azurerm_linux_function_app" "node_linux_func" {
  name                          = "func${random_integer.rand_int.result}"
  resource_group_name           = azurerm_resource_group.func_rg.name
  location                      = azurerm_resource_group.func_rg.location
  service_plan_id               = azurerm_service_plan.linux_service_plan.id
  storage_account_name          = azurerm_storage_account.func_store.name
  storage_account_access_key    = azurerm_storage_account.func_store.primary_access_key
  https_only                    = true
  public_network_access_enabled = false
  site_config {
    application_insights_key               = azurerm_application_insights.func_insight.instrumentation_key
    application_insights_connection_string = azurerm_application_insights.func_insight.connection_string
    application_stack {
      node_version = "18"
    }
  }
  auth_settings {
    enabled = true
  }
  app_settings = {
    NODE_ENV = var.node_env
  }
}
