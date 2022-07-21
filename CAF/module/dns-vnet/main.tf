terraform {
  required_providers {
    azurerm = {
      configuration_aliases = [azurerm.main]
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg-name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.address_space]
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-dnshost"
  address_prefixes     = [var.dns_subnet_range]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  for_each              = var.private_dns_zones
  resource_group_name   = var.rg_dns_zones
  name                  = "link_vnet_dns"
  private_dns_zone_name = each.value.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_storage_account" "sa_script" {
  name = var.rg_storageaccount_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sa_container" {
  name                  = "script"
  storage_account_name  = azurerm_storage_account.sa_script.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "script" {
  name                   = "set-dnsforwarders.ps1"
  storage_account_name   = azurerm_storage_account.sa_script.name
  storage_container_name = azurerm_storage_container.sa_container.name
  type                   = "Block"
  source                 = "${path.module}/scripts/set-dnsforwarders.ps1"
}


### DNS-VM-1 ###

resource "azurerm_network_interface" "nic1" {
  name                = "dns-nic-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.12.2.4"
  }
}

resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "vm-platf-dns-01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2as_v5"
  admin_username      = var.username_dns_servers
  admin_password      = "P@$$w0rd1234!"
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

resource "azurerm_virtual_machine_extension" "ext1" {
  name                 = "dns_settings"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm1.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  protected_settings = <<PROTECTED_SETTINGS
    {
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted -NoProfile -NonInteractive -File set-dnsforwarders.ps1",
        "storageAccountName": "${azurerm_storage_account.sa_script.name}",
        "storageAccountKey": "${azurerm_storage_account.sa_script.primary_access_key}",
        "fileUris": [
          "${azurerm_storage_blob.script.url}"
        ]
    }
PROTECTED_SETTINGS


  tags = {
    environment = "Production"
  }

}

# ### DNS-VM-2 ###

resource "azurerm_network_interface" "nic2" {
  name                = "dns-nic-02"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.12.2.5"
  }
}

resource "azurerm_windows_virtual_machine" "vm2" {
  name                = "vm-platf-dns-02"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2as_v5"
  admin_username      = var.username_dns_servers
  admin_password      = "P@$$w0rd1234!"
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

resource "azurerm_virtual_machine_extension" "ext2" {
  name                 = "dns_settings"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm2.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  protected_settings = <<PROTECTED_SETTINGS
    {
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted -NoProfile -NonInteractive -File set-dnsforwarders.ps1",
        "storageAccountName": "${azurerm_storage_account.sa_script.name}",
        "storageAccountKey": "${azurerm_storage_account.sa_script.primary_access_key}",
        "fileUris": [
          "${azurerm_storage_blob.script.url}"
        ]
    }
PROTECTED_SETTINGS


  tags = {
    environment = "Production"
  }

}
