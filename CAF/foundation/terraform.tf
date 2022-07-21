# Configure Terraform to set the required AzureRM provider
# version and features{} block.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.2, < 4.0.0"
      configuration_aliases = [
        azurerm.management,
        azurerm.connectivity
      ]
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.19.1"
    }
  }
}

terraform {
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
  subscription_id = "8f96df25-1520-42ea-8a60-4a32c86cc31b"
}


provider "azurerm" {
  alias           = "management"
  subscription_id = "8f96df25-1520-42ea-8a60-4a32c86cc31b"
  features {}
}

provider "azurerm" {
  alias           = "connectivity"
  subscription_id = "660ed425-d323-4fa1-b428-11fc237e57a4"
  features {}
}

provider "azurerm" {
  alias           = "identity"
  subscription_id = "e6fa205b-b05f-48d0-b3ce-8c74c00f3982"
  features {}
}

provider "azurerm" {
  alias           = "fds"
  subscription_id = "2ce5d158-b783-4da7-9022-11f0be6e8dcb"
  features {}
}
