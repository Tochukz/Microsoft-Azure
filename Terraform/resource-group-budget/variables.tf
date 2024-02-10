variable "location" {
  type    = string
  description = "The resource group location"
  default = "westeurope"
}
variable "contact_emails_string" {
  type    = string
  description = "A list of contact emails for subscription budget notificaiton"
}
