resource "azurerm_key_vault" "lz_key_vault" {
  count                       = var.key_vault ? 1 : 0
  name                        = module.naming.key_vault.name_unique
  location                    = azurerm_resource_group.lz_resource_groups["rg-shared-${var.environment}-${var.postfix}"].location
  resource_group_name         = azurerm_resource_group.lz_resource_groups["rg-shared-${var.environment}-${var.postfix}"].name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  # Set to true if vm workloads are intended in this landing zone
  enabled_for_deployment    = var.vm_workloads
  enable_rbac_authorization = var.use_rbac_for_keyvault
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

# resource "azurerm_role_assignment" "spn_to_kv" {
#   count                            = var.key_vault ? 1 : 0
#   scope                            = azurerm_key_vault.lz_key_vault.0.id
#   role_definition_name             = "Key Vault Secrets Officer"
#   principal_id                     = azuread_service_principal.spn.object_id
#   skip_service_principal_aad_check = false
# }

resource "azurerm_role_assignment" "current_spn_to_kv" {
  count                = var.key_vault ? 1 : 0
  scope                = azurerm_key_vault.lz_key_vault.0.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

# resource "azurerm_key_vault_secret" "spn_secret" {
#   count = var.key_vault ? 1 : 0
#   depends_on = [
#     azurerm_role_assignment.spn_to_kv,
#     azurerm_role_assignment.current_spn_to_kv
#   ]
#   name         = "spn-secret"
#   value        = azuread_application_password.spn_secret.value
#   key_vault_id = azurerm_key_vault.lz_key_vault.0.id
#   timeouts {
#     create = "10m"
#   }
# }
