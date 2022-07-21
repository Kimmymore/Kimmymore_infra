# TODO, add policy to auto onboard Virtual Machines

resource "azurerm_recovery_services_vault" "vault" {
  name                = "rsv-${var.workload_name}-${var.env}-${var.postfix}"
  resource_group_name = azurerm_resource_group.rg_identity_dc.name
  location            = azurerm_resource_group.rg_identity_dc.location
  sku                 = "Standard"

  soft_delete_enabled = true
  storage_mode_type   = "GeoRedundant"

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}