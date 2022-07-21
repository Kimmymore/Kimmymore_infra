
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.workload-name}-${var.regioncode}-format("%03d", var.instancenumber)"
  location = var.location
}

resource "azurerm_subnet" "subnet" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = var.bastion_vnet-name
  resource_group_name  = var.bastion_vnet-rg-name
  address_prefixes     = [var.bastion_subnet-range]
}

resource "azurerm_public_ip" "public_ip" {
  name = "pip-${var.workload-name}-${var.regioncode}-format("%03d", var.instancenumber)"
  resource_group_name = azurerm_resource_group.rg.name 
  location = azurerm_resource_group.rg.location
  sku = "Standard" 
  allocation_method = "Static"
}

resource "azurerm_bastion_host" "bastion_host" {
  depends_on = [azurerm_public_ip.public_ip]

  name = "bas-${var.workload-name}-${var.regioncode}-format("%03d", var.instancenumber)"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location

  ip_configuration {
    name                 = "ipconfiguration"
    subnet_id            = azurerm_subnet.subnet.id
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}



