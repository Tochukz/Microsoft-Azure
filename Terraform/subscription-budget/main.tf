terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate9204"
    container_name       = "tfstate"
    key                  = "subscription-budget/terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    
  }
}

data "azurerm_subscription" "current" {
  
}

locals {
  contact_emails = split(",", var.contact_emails_string)
}
resource "azurerm_resource_group" "budget_rg" {
  name = "SubscriptionBudgetRG"
  location = var.location
}

# With the azurerm_monitor_action_group you can configure sms_receiver, email_reveiver, azure_function_receiver, webhook_receiver, voice_receiver etc
resource "azurerm_monitor_action_group" "action_group" {
  name = "SimpleBudgetAction"
  resource_group_name = azurerm_resource_group.budget_rg.name
  short_name = "monitor"
  sms_receiver {
    name = "MessageMe"
    country_code = var.country_code
    phone_number = var.phone_number
  }
  email_receiver {
    name = "EmailMe"
    email_address = var.receiver_email
  }
}

resource "azurerm_consumption_budget_subscription" "subscription_budget" {
  name = "SubscriptionBudget"
  subscription_id = data.azurerm_subscription.current.id
  amount = 5  # $5 budget
  time_grain = "Monthly"
  time_period {
    start_date = "2024-02-01T00:00:00Z"
  }
  notification {
    enabled = true 
    threshold = 50 # 50% threshold
    operator = "GreaterThan"
    contact_emails = local.contact_emails
    contact_groups = [
      azurerm_monitor_action_group.action_group.id
    ]
  }
  notification {
    enabled = true 
    threshold = 80 # 80% threshold
    operator = "GreaterThan"
    threshold_type = "Forecasted" 
    contact_emails = [ local.contact_emails[0] ]
  }
}