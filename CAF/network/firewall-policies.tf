resource "azurerm_firewall_policy" "firewall_policy" {
  name                = "fwp-platform-${var.env}-${var.postfix}"
  resource_group_name = azurerm_resource_group.rg-vwan-fw-policy.name
  location            = var.location
  sku                 = "Premium"
}
