resource "random_pet" "random_name" {
}

resource "azurerm_resource_group" "cdn_rg" {
  name     = "cdn-rg"
  location = var.group_location
}

resource "random_string" "number" {
  length  = 6
  lower   = false
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_cdn_profile" "profile" {
  name                = "profile-${random_string.number.result}"
  location            = azurerm_resource_group.cdn_rg.location
  resource_group_name = azurerm_resource_group.cdn_rg.name
  sku                 = var.cdn_sku
}

resource "azurerm_storage_account" "cdn_store" {
  name                     = "cdnstore${random_string.number.id}"
  resource_group_name      = azurerm_resource_group.cdn_rg.name
  location                 = azurerm_resource_group.cdn_rg.location
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
  storage_account_name   = azurerm_storage_account.cdn_store.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}

resource "azurerm_cdn_endpoint" "endpoint" {
  name                = random_pet.random_name.id
  profile_name        = azurerm_cdn_profile.profile.name
  resource_group_name = azurerm_resource_group.cdn_rg.name
  location            = azurerm_resource_group.cdn_rg.location
  # origin_host_header            = azurerm_storage_account.cdn_store.primary_web_host
  is_http_allowed               = true
  is_https_allowed              = true
  querystring_caching_behaviour = "IgnoreQueryString"
  is_compression_enabled        = true
  content_types_to_compress = [
    "application/eot",
    "application/font",
    "application/font-sfnt",
    "application/javascript",
    "application/json",
    "application/opentype",
    "application/otf",
    "application/pkcs7-mime",
    "application/truetype",
    "application/ttf",
    "application/vnd.ms-fontobject",
    "application/xhtml+xml",
    "application/xml",
    "application/xml+rss",
    "application/x-font-opentype",
    "application/x-font-truetype",
    "application/x-font-ttf",
    "application/x-httpd-cgi",
    "application/x-javascript",
    "application/x-mpegurl",
    "application/x-opentype",
    "application/x-otf",
    "application/x-perl",
    "application/x-ttf",
    "font/eot",
    "font/ttf",
    "font/otf",
    "font/opentype",
    "image/svg+xml",
    "text/css",
    "text/csv",
    "text/html",
    "text/javascript",
    "text/js",
    "text/plain",
    "text/richtext",
    "text/tab-separated-values",
    "text/xml",
    "text/x-script",
    "text/x-component",
    "text/x-java-source",
  ]
  origin {
    name      = "simple-origin"
    host_name = azurerm_storage_account.cdn_store.primary_web_host
  }
  # delivery_rule {
  #   name  = "spaURLReroute"
  #   order = "1"

  #   url_file_extension_condition {
  #     operator     = "LessThan"
  #     match_values = ["1"]
  #   }

  #   url_rewrite_action {
  #     destination             = "/index.html"
  #     preserve_unmatched_path = "false"
  #     source_pattern          = "/"
  #   }
  # }
  # delivery_rule {
  #   name  = "EnforceHTTPS"
  #   order = "2"

  #   request_scheme_condition {
  #     operator     = "Equal"
  #     match_values = ["HTTP"]
  #   }

  #   url_redirect_action {
  #     redirect_type = "Found"
  #     protocol      = "Https"
  #   }
  # }
}
