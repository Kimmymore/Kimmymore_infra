resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.workload-name}-${var.regioncode}-format("%03d", var.instancenumber)"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.mgmt_vnet-name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.mgmt_address_space]
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-mgmt"
  address_prefixes     = [var.mgmt_subnet_range]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
}