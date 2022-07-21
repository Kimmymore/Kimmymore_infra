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
  subscription_id = "8f96df25-1520-42ea-8a60-4a32c86cc31b"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "azurerm" {
  alias           = "connectivity"
  subscription_id = "660ed425-d323-4fa1-b428-11fc237e57a4"
  features {}
}

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_virtual_hub" "vwan_hub" {
  provider            = azurerm.connectivity
  name                = "hub-platform-prd-weu-001"
  resource_group_name = "rg-network-vwan-${var.env}-${var.postfix}"
}

resource "azurerm_resource_group" "rg_management" {
  name     = "rg-${var.workload_name}-${var.env}-${var.postfix}"
  location = var.location
  tags = {
    "WorkloadName" = var.workload_name,
    "Environment" = var.env,
    "Owner" = var.owner,
    "DeployedBy" = var.deployed_by
  }
}

