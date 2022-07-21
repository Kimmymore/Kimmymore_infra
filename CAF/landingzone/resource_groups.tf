locals {
  resource_groups = {
    "rg-shared-${var.environment}-${var.postfix}"     = var.location,
    "rg-networking-${var.environment}-${var.postfix}" = var.location,
  }
}

resource "azurerm_resource_group" "lz_resource_groups" {
  for_each = local.resource_groups
  name     = each.key
  location = each.value
  tags     = local.tags
}
