variable "location" {
  type        = string
  description = "Azure location"
  default     = "westeurope"
}
variable "node_env" {
  type        = string
  description = "Node environment variable"
  default     = "development"
}
