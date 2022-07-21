# IP groups: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ip_group


resource "azurerm_ip_group" "accon_group" {
  name                = "ipgr-accon-${var.env}-${var.postfix}"
  location            = azurerm_resource_group.rg_ip_groups.location
  resource_group_name = azurerm_resource_group.rg_ip_groups.name

  cidrs = ["10.63.0.0/22",
            "10.64.0.0/22",
            "10.59.0.0/21",
            "10.65.0.0/20",
            "10.58.0.0/21",
            "10.61.0.0/22",
            "10.62.0.0/22",
            "10.60.0.0/22"
  ]
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
