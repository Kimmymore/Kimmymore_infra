# Configure Terraform to set the required AzureRM provider
# version and features{} block.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.2, < 4.0.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.19.1"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = "2ce5d158-b783-4da7-9022-11f0be6e8dcb"
  features {
  }
}


provider "azurerm" {
  alias = "virtualwan"
  subscription_id = "660ed425-d323-4fa1-b428-11fc237e57a4"
  features {}
}

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}
