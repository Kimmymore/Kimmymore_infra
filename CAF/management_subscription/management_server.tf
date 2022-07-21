resource "azurerm_network_interface" "nic_mngmnt" {
  name                = "nic-mngmnt-${var.env}-${var.postfix}"
  location            = azurerm_resource_group.rg_management.location
  resource_group_name = azurerm_resource_group.rg_management.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mngmnt.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.224.2.75"
  }
}

resource "azurerm_windows_virtual_machine" "mngmnt_server" {
  name                = "vm-${var.workload_name}-${var.env}-${var.postfix}"
  computer_name       = "vm-management"
  resource_group_name = azurerm_resource_group.rg_management.name
  location            = azurerm_resource_group.rg_management.location
  size                = "Standard_B2ms"
  admin_username      = var.username_mngmnt
  admin_password      = azurerm_key_vault_secret.mngmnt_secret.value
  network_interface_ids = [
    azurerm_network_interface.nic_mngmnt.id,
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
