variable "group_location" {
  type        = string
  description = "The location for the reqource group"
  default     = "westeurope"
}

variable "origin_url" {
  type        = string
  description = "The origin server hostname"
  default     = "lab.firdcare.com"
}

variable "cdn_sku" {
  type        = string
  description = "CDN SKU names."
  default     = "Standard_Microsoft"
  validation {
    condition     = contains(["Standard_Akamai", "Standard_Microsoft", "Standard_Verizon", "Premium_Verizon"], var.cdn_sku)
    error_message = "The cdn_sku must be one of the following: Standard_Akamai, Standard_Microsoft, Standard_Verizon, Premium_Verizon."
  }
}
