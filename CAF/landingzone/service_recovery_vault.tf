# TODO, add policy to auto onboard Virtual Machines

resource "azurerm_recovery_services_vault" "vault" {
  count               = var.vm_workloads ? 1 : 0
  name                = "rsv-shared-${var.environment}-${var.postfix}"
  resource_group_name = azurerm_resource_group.lz_resource_groups["rg-shared-${var.environment}-${var.postfix}"].name
  location            = azurerm_resource_group.lz_resource_groups["rg-shared-${var.environment}-${var.postfix}"].location
  sku                 = "Standard"

  soft_delete_enabled = true
  storage_mode_type   = "GeoRedundant"

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}