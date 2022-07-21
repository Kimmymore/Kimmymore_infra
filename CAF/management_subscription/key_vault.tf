resource "azurerm_key_vault" "mngmnt_kv" {
  name                        = "kv${var.workload_name}${var.env}${var.postfix}"
  location                    = azurerm_resource_group.rg_management.location
  resource_group_name         = azurerm_resource_group.rg_management.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  # Set to true if vm workloads are intended in this landing zone
  enabled_for_deployment    = true
  enable_rbac_authorization = true
  sku_name                  = "standard"

  # TODO: Depending on default subnets networking rules can be added, on the subnet
  # A key vault service endpoint needs to be enabled as well
  #   network_acls {
  #     bypass = "AzureServices"
  #     default_action = "Deny"
  #     virtual_network_subnet_ids =
  #   }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# assign current deployment SPN as secret officer
resource "azurerm_role_assignment" "current_spn_to_kv" {
  scope                = azurerm_key_vault.mngmnt_kv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "random_password" "mngmnt_pw" {
  length           = 20
  min_lower        = 4
  min_numeric      = 4
  min_special      = 4
  min_upper        = 4
}


resource "azurerm_key_vault_secret" "mngmnt_secret" {
  depends_on = [
    azurerm_role_assignment.current_spn_to_kv
  ]
  name         = "mngmnt-pw"
  value        = random_password.mngmnt_pw.result
  key_vault_id = azurerm_key_vault.mngmnt_kv.id
  timeouts {
    create = "10m"
  }
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
