variable "location" {
  type = string 
  description = "The resource group location"
  default = "westeurope"
}
variable "contact_emails_string" {
  type = string 
  description = "A list of contact emails for subscription budget notificaiton"
}
variable "receiver_email" {
  type = string 
  description = "A single email address for action group email receiverr"
}
variable "country_code" {
  type = string 
  description = "Country code for action group sms receiver"
  default = "27"
}
variable "phone_number" {
  type = string 
  description = "A phone number for action group sms receiver"
}