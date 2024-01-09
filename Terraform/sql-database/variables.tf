variable "location" {
  type        = string
  description = "Azure location"
  default     = "westeurope"
}

variable "db_name" {
  type        = string
  description = "Database name"
  default     = "SimpleDb"
}

variable "admin_user" {
  type        = string
  description = "Administrator login user"
  default     = "simpleadmin"
}

variable "admin_password" {
  type        = string
  description = "Administrator password"
  sensitive   = true
  default     = null
}

