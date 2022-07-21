resource "azurerm_virtual_network" "vnet" {
  name          = "vnet-${var.workload_name}-${var.env}-${var.postfix}"
  address_space = [var.vnet_cidr]
  resource_group_name = azurerm_resource_group.rg_identity_network.name
  location            = azurerm_resource_group.rg_identity_network.location

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_virtual_hub_connection" "vnet_peering" {
  provider                  = azurerm.connectivity
  name                      = "vcon-${data.azurerm_virtual_hub.vwan_hub.name}-hub-to-${azurerm_virtual_network.vnet.name}"
  virtual_hub_id            = data.azurerm_virtual_hub.vwan_hub.id
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
  internet_security_enabled = true
}

resource "azurerm_subnet" "domain_controller" {
  name                 = "DcSubnet"
  address_prefixes     = [var.domain_controller_subnet_cidr]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg_identity_network.name
}

module "azurerm_network_security_group" {
  source = "../module/default-nsg"
  name                = "nsg-dc-snet-${var.env}-${var.postfix}"
  location            = azurerm_resource_group.rg_identity_network.location
  resource_group_name = azurerm_resource_group.rg_identity_network.name
}

resource "azurerm_subnet_network_security_group_association" "identity_nsg_assoc" {
  subnet_id                 = azurerm_subnet.domain_controller.id
  network_security_group_id = module.azurerm_network_security_group.nsg_id
}
