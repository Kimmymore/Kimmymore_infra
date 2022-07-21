resource "azurerm_network_interface" "nic1" {
  name                = "nic-dc1-${var.env}-${var.postfix}"
  location            = azurerm_resource_group.rg_identity_dc.location
  resource_group_name = azurerm_resource_group.rg_identity_dc.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.domain_controller.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.224.3.4"
  }
}

resource "azurerm_network_interface" "nic2" {
  name                = "nic-dc2-${var.env}-${var.postfix}"
  location            = azurerm_resource_group.rg_identity_dc.location
  resource_group_name = azurerm_resource_group.rg_identity_dc.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.domain_controller.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.224.3.5"
  }
}

resource "azurerm_windows_virtual_machine" "dc1" {
  name                = "vm-dc1-${var.env}-${var.postfix}"
  computer_name       = "vm-dc1-${var.postfix}"
  resource_group_name = azurerm_resource_group.rg_identity_dc.name
  location            = azurerm_resource_group.rg_identity_dc.location
  size                = "Standard_D2as_v5"
  admin_username      = var.username_dc1
  admin_password      = azurerm_key_vault_secret.dc1_secret.value
  network_interface_ids = [
    azurerm_network_interface.nic1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "dc2" {
  name                = "vm-dc2-${var.env}-${var.postfix}"
  computer_name       = "vm-dc2-${var.postfix}"
  resource_group_name = azurerm_resource_group.rg_identity_dc.name
  location            = azurerm_resource_group.rg_identity_dc.location
  size                = "Standard_D2as_v5"
  admin_username      = var.username_dc2
  admin_password      = azurerm_key_vault_secret.dc2_secret.value
  network_interface_ids = [
    azurerm_network_interface.nic2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}