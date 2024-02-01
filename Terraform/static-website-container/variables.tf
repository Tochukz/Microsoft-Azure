variable "resource_group_prefix" {
  type        = string
  description = "Prefix for the resource group name"
  default     = "staticweb"
}
variable "group_location" {
  type        = string
  description = "Locatiion for the resource group"
  default     = "southafricanorth"
}
variable "resource_location" {
  type        = string
  description = "Location for other resources"
  default     = "westeurope"
}
variable "environment" {
  type        = string
  description = "The deployment environment e.g development"
  default     = "development"
}
