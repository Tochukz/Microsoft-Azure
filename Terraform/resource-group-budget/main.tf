terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}


provider "azurerm" {
  features {

  }
}

locals {
  contact_emails = split(",", var.contact_emails_string)
}

resource "azurerm_resource_group" "budget_rg" {
  name     = "budget-rg"
  location = "westeurope"
}

resource "azurerm_consumption_budget_resource_group" "group_budget" {
  name              = "SimpleGroupBudget"
  resource_group_id = azurerm_resource_group.budget_rg.id
  amount            = 5
  time_grain        = "Monthly"
  time_period {
    start_date = "2024-02-01T00:00:00Z"
  }
  #   filter {
  #     tag {
  #       name   = "GroupName"
  #       values = ["BudgetDev"]
  #     }
  #   }
  notification {
    enabled        = true
    threshold      = 2
    operator       = "GreaterThan"
    contact_emails = local.contact_emails
  }
}
