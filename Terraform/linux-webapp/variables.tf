variable "location" {
  type = string 
  description = "Azure region for the workload"
  default = "westeurope"
}
variable "node_env" {
  type = string 
  description = "Node environment"
  default = "development"
  
}