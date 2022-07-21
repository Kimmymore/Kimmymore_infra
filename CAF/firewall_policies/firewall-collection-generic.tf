# Docs: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy_rule_collection_group

resource "azurerm_firewall_policy_rule_collection_group" "on_premise" {
  name               = "Rcg-generic"
  firewall_policy_id = data.azurerm_firewall_policy.fwp.id
  priority           = 500

  # application_rule_collection {
  #   name     = "app_rule_collection1"
  #   priority = 500
  #   action   = "Deny"
  #   rule {
  #     name = "app_rule_collection1_rule1"
  #     protocols {
  #       type = "Http"
  #       port = 80
  #     }
  #     protocols {
  #       type = "Https"
  #       port = 443
  #     }
  #     source_addresses  = ["10.0.0.1"]
  #     destination_fqdns = [".microsoft.com"]
  #   }
  # }

  network_rule_collection {
    name     = "network-generic-allow"
    priority = 1000
    action   = "Allow"
    rule {
      name                  = "foundation_to_onpremdc"
      protocols             = ["Any"]
      source_addresses      = [var.foundation_ip_range]
      destination_addresses = ["172.21.0.0/16"]
      destination_ports     = ["*"]
    }
    rule {
      name                  = "onpremdc_to_foundation"
      protocols             = ["Any"]
      source_addresses      = ["172.21.0.0/16"]
      destination_addresses = [var.foundation_ip_range]
      destination_ports     = ["*"]
    }
    rule {
      name                  = "foundation_to_accon"
      protocols             = ["Any"]
      source_addresses      = [var.foundation_ip_range]
      destination_ip_groups = [azurerm_ip_group.accon_group.id]
      destination_ports     = ["*"]
    }
    rule {
      name                  = "accon_to_foundation"
      protocols             = ["Any"]
      source_ip_groups      = [azurerm_ip_group.accon_group.id]
      destination_addresses = [var.foundation_ip_range]
      destination_ports     = ["*"]
    }
  }

  # nat_rule_collection {
  #   name     = "nat_rule_collection1"
  #   priority = 300
  #   action   = "Dnat"
  #   rule {
  #     name                = "nat_rule_collection1_rule1"
  #     protocols           = ["TCP", "UDP"]
  #     source_addresses    = ["10.0.0.1", "10.0.0.2"]
  #     destination_address = "192.168.1.1"
  #     destination_ports   = ["80", "1000-2000"]
  #     translated_address  = "192.168.0.1"
  #     translated_port     = "8080"
  #   }
  # }
}
