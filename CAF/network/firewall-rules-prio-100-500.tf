# resource "azurerm_firewall_network_rule_collection" "collection_100_allow" {
#   name                = "collection_100_allow"
#   azure_firewall_name = azurerm_firewall.vwan_firewall.name
#   resource_group_name = azurerm_resource_group.rg_vwan_network.name
#   priority            = 100
#   action              = "Allow"

#   rule {
#     name = "ruletest"
#     source_addresses = ["10.0.0.0/16",]
#     destination_ports = ["53",]
#     destination_addresses = ["8.8.8.8","8.8.4.4",]
#     protocols = ["TCP","UDP",]
#   }

#   rule {
#     name = "ruletest2"
#     source_addresses = ["10.0.0.0/16",]
#     destination_ports = ["53",]
#     destination_addresses = ["8.8.8.8","8.8.4.4",]
#     protocols = ["TCP","UDP",]
#   }
# }

# resource "azurerm_firewall_network_rule_collection" "collection_100_deny" {
#   name                = "collection_100_deny"
#   azure_firewall_name = azurerm_firewall.vwan_firewall.name
#   resource_group_name = azurerm_resource_group.rg_vwan_network.name
#   priority            = 100
#   action              = "Deny"

#   rule {
#     name = "ruletest"
#     source_addresses = ["10.0.0.0/16",]
#     destination_ports = ["53",]
#     destination_addresses = ["8.8.8.8","8.8.4.4",]
#     protocols = ["TCP","UDP",]
#   }

#   rule {
#     name = "ruletest2"
#     source_addresses = ["10.0.0.0/16",]
#     destination_ports = ["53",]
#     destination_addresses = ["8.8.8.8","8.8.4.4",]
#     protocols = ["TCP","UDP",]
#   }
# }