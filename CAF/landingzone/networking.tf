resource "azurerm_virtual_network" "vnet" {
  name          = "vnet-${var.workload_name}-${var.environment}-${var.postfix}"
  address_space = [var.vnet_cidr]
  resource_group_name = azurerm_resource_group.lz_resource_groups["rg-networking-${var.environment}-${var.postfix}"].name
  location            = azurerm_resource_group.lz_resource_groups["rg-networking-${var.environment}-${var.postfix}"].location

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

data "azurerm_virtual_hub" "vwan_hub" {
  provider            = azurerm.virtualwan
  name                = "hub-platform-prd-weu-001"
  resource_group_name = "rg-network-vwan-${var.environment}-${var.postfix}"
}

resource "azurerm_virtual_hub_connection" "vnet_peering" {
  provider                  = azurerm.virtualwan
  name                      = "vcon-${data.azurerm_virtual_hub.vwan_hub.name}-hub-to-${azurerm_virtual_network.vnet.name}"
  virtual_hub_id            = data.azurerm_virtual_hub.vwan_hub.id
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
  internet_security_enabled = true
}
