resource "azurerm_virtual_wan" "vwan" {
  resource_group_name = azurerm_resource_group.rg_vwan_network.name
  name                = "vwan-platform-${var.env}-${var.postfix}"
  location            = azurerm_resource_group.rg_vwan_network.location

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_virtual_hub" "vwan_hub_weu" {
  name                = "hub-platform-${var.env}-${var.postfix}"
  resource_group_name = azurerm_resource_group.rg_vwan_network.name
  location            = azurerm_resource_group.rg_vwan_network.location
  virtual_wan_id      = azurerm_virtual_wan.vwan.id
  address_prefix      = "10.224.250.0/23"
  sku                 = "Standard"

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_firewall" "vwan_firewall" {
  name                = "fw-platform-${var.env}-${var.postfix}"
  location            = azurerm_resource_group.rg_vwan_network.location
  resource_group_name = azurerm_resource_group.rg_vwan_network.name

  sku_name           = "AZFW_Hub"
  sku_tier           = "Premium"
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id

  # threat_intel_mode = ""
  virtual_hub {
    virtual_hub_id  = azurerm_virtual_hub.vwan_hub_weu.id
    public_ip_count = 1
  }

  # Firewall should be highly available and span more then 1 Zone.
  zones = ["1", "2"]

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
