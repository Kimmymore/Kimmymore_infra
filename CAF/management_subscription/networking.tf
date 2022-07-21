resource "azurerm_virtual_network" "vnet" {
  name          = "vnet-${var.workload_name}-${var.env}-${var.postfix}"
  address_space = [var.vnet_cidr]
  resource_group_name = azurerm_resource_group.rg_management.name
  location            = azurerm_resource_group.rg_management.location

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

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  address_prefixes     = [var.bastion_subnet_cidr]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg_management.name
}

resource "azurerm_subnet" "mngmnt" {
  name                 = "MngmntSubnet"
  address_prefixes     = [var.mngmnt_subnet_cidr]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg_management.name
}

resource "azurerm_public_ip" "public_ip" {
  name = "pip-${var.workload_name}-${var.env}-${var.postfix}"
  resource_group_name = azurerm_resource_group.rg_management.name
  location = azurerm_resource_group.rg_management.location
  sku = "Standard"
  allocation_method = "Static"
}

module "nsg_mngmnt_subnet" {
  source = "../module/default-nsg"
  name                = "nsg-${var.workload_name}-${var.env}-${var.postfix}"
  location            = azurerm_resource_group.rg_management.location
  resource_group_name = azurerm_resource_group.rg_management.name
}

resource "azurerm_subnet_network_security_group_association" "bastion_nsg_assoc" {
  subnet_id                 = azurerm_subnet.bastion.id
  network_security_group_id = azurerm_network_security_group.nsg_bastion.id
}

resource "azurerm_subnet_network_security_group_association" "mngmnt_nsg_assoc" {
  subnet_id                 = azurerm_subnet.mngmnt.id
  network_security_group_id = module.nsg_mngmnt_subnet.nsg_id
}
