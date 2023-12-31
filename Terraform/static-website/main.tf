data "azurerm_client_config" "current" {}

resource "random_pet" "group_name" {
  prefix = var.resource_group_prefix
}

resource "azurerm_resource_group" "static_rg" {
  name     = random_pet.group_name.id
  location = var.group_location
}

resource "random_string" "random_name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_storage_account" "static_store" {
  name                     = "staticstore${random_string.random_name.id}"
  resource_group_name      = azurerm_resource_group.static_rg.name
  location                 = var.resource_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }
}

resource "azurerm_storage_blob" "index_blob" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.static_store.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}
