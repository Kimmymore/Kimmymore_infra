resource "azurerm_vpn_gateway" "vpn_gateway" {
  name                = "vpng-platform-${var.env}-${var.postfix}"
  location            = azurerm_resource_group.rg_vwan_network.location
  resource_group_name = azurerm_resource_group.rg_vwan_network.name
  virtual_hub_id      = azurerm_virtual_hub.vwan_hub_weu.id
  routing_preference  = "Microsoft Network"
  scale_unit          = "1"

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_vpn_site" "accon_vwan_site" {
  name                = "site-accon-vwan"
  resource_group_name = azurerm_resource_group.rg_vwan_network.name
  location            = azurerm_resource_group.rg_vwan_network.location
  virtual_wan_id      = azurerm_virtual_wan.vwan.id
  address_cidrs       = ["10.58.0.0/21","10.59.0.0/21","10.60.0.0/22","10.61.0.0/22","10.62.0.0/22","10.63.0.0/22","10.64.0.0/22","10.65.0.0/20"]
  device_model        = "VWAN Hub"
  device_vendor       = "Azure"
  link {
    name       = "link_1_accon_vwan"
    ip_address = "20.101.14.30"
    provider_name = "Azure"
    speed_in_mbps = "500"
  }
  link {
    name       = "link_2_accon_vwan"
    ip_address = "20.101.14.156"
    provider_name = "Azure"
    speed_in_mbps = "500"
  }
}

resource "azurerm_vpn_gateway_connection" "accon_vwan_site" {
  name               = "vpngwconn-accon-vwan"
  vpn_gateway_id     = azurerm_vpn_gateway.vpn_gateway.id
  remote_vpn_site_id = azurerm_vpn_site.accon_vwan_site.id

  vpn_link {
    name             = "vpn_link_accon"
    vpn_site_link_id = azurerm_vpn_site.accon_vwan_site.link[0].id
  }
}

data "azurerm_log_analytics_workspace" "platform_workspace" {
    provider = azurerm.management
    name = "log-platform-prd-weu-001"
    resource_group_name = "rg-platform-management-prd-weu-001"
}

resource "azurerm_monitor_diagnostic_setting" "vpn_gw_diagnostics" {
  name               = "vpn_gateway_logs"
  target_resource_id = azurerm_vpn_gateway.vpn_gateway.id
  log_analytics_workspace_id  = data.azurerm_log_analytics_workspace.platform_workspace.id

  log {
    category = "GatewayDiagnosticLog"
    enabled  = true
  }

  log {
    category = "TunnelDiagnosticLog"
    enabled  = true
  }
  log {
    category = "RouteDiagnosticLog"
    enabled  = true
  }
  log {
    category = "IKEDiagnosticLog"
    enabled  = true
  }

  metric {
    category = "AllMetrics"
  }
}