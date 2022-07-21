resource "azurerm_bastion_host" "bastion_host" {
  depends_on = [azurerm_public_ip.public_ip]

  name = "bas-${var.workload_name}-${var.env}-${var.postfix}"
  resource_group_name = azurerm_resource_group.rg_management.name
  location =  azurerm_resource_group.rg_management.location
  sku = "Standard"
  copy_paste_enabled = true
  file_copy_enabled = false
  ip_connect_enabled = true
  scale_units = 2
  shareable_link_enabled = false
  tunneling_enabled = false

  ip_configuration {
    name                 = "ipconfiguration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
