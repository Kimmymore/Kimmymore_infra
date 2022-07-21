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
  subscription_id = "660ed425-d323-4fa1-b428-11fc237e57a4"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "azurerm" {
  alias           = "management"
  subscription_id = "8f96df25-1520-42ea-8a60-4a32c86cc31b"
  features {}
}

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "rg_vwan_network" {
  name     = "rg-network-vwan-${var.env}-${var.postfix}"
  location = var.location
  tags = {
    "WorkloadName" = "hub_networking",
    "Environment" = "prd",
    "Owner" = "Kim Willemse",
    "DeployedBy" = "Kim Willemse"
  }
}

resource "azurerm_resource_group" "rg-vwan-fw-policy" {
  name     = "rg-fw-policy-${var.env}-${var.postfix}"
  location = var.location
  tags = {
    "WorkloadName" = "firewall_policies",
    "Environment" = "prd",
    "Owner" = "Kim Willemse",
    "DeployedBy" = "Kim Willemse"
  }
}
