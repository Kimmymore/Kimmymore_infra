terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.19.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.2, < 4.0.0"
    }
    time = {
        source = "hashicorp/time"
        version = ">= 0.7.2, < 1.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}
