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

data "azurerm_resource_group" "rg_fw_policy" {
  name     = "rg-fw-policy-prd-weu-001"
}

data "azurerm_firewall_policy" "fwp" {
  name                = "fwp-platform-prd-weu-001"
  resource_group_name = data.azurerm_resource_group.rg_fw_policy.name
}

resource "azurerm_resource_group" "rg_ip_groups" {
  name     = "rg-${var.workload_name}-${var.env}-${var.postfix}"
  location = var.location
  tags = {
    "WorkloadName" = var.workload_name,
    "Environment" = var.env,
    "Owner" = var.owner,
    "DeployedBy" = var.deployed_by
  }
}
